//
//  Locale+ContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Locale {
    
    /// This modifier can apply a locale context menu to any
    /// view or keyboard button.
    ///
    /// Use ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)``
    /// to apply this menu, which then only applies when the
    /// provided locales or ``KeyboardContext/enabledLocales``
    /// have at least two locales. It will sort and localize
    /// the list with ``KeyboardContext/localePresentationLocale``.
    ///
    /// The ``KeyboardView`` automatically applies this menu
    /// to all keys that trigger ``KeyboardAction/nextLocale``.
    struct ContextMenu<MenuItem: View>: ViewModifier {
        
        /// Create a menu that lists locales as `Text` views
        /// with the full localized name.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: An explicit list of locales to show, if any.
        ///   - tapAction: The action to trigger when the view is tapped.
        public init(
            keyboardContext: KeyboardContext,
            locales: [Locale]? = nil,
            tapAction: @escaping () -> Void
        ) where MenuItem == Text {
            self.init(
                keyboardContext: keyboardContext,
                locales: locales,
                tapAction: tapAction
            ) { locale, layoutType in
                let presentation = keyboardContext.localePresentationLocale ?? locale
                let localeName = locale.localizedName(in: presentation) ?? locale.identifier
                if let layout = layoutType {
                    return Text("\(localeName) - \(layout.displayName)")
                } else {
                    return Text("\(localeName)")
                }
            }
        }
        
        /// Create a menu that lists locales as custom views.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: An explicit list of locales to show, if any.
        ///   - tapAction: The action to trigger when the view is tapped.
        ///   - menuItem: A menu item view builder.
        public init(
            keyboardContext: KeyboardContext,
            locales: [Locale]? = nil,
            tapAction: @escaping () -> Void,
            @ViewBuilder menuItem: @escaping (Locale, Keyboard.LayoutType?) -> MenuItem
        ) {
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
            self.locales = locales.map { .init($0) }
            self.tapAction = tapAction
            self.menuItem = menuItem
        }
        
        @ObservedObject
        private var keyboardContext: KeyboardContext

        private var locales: [Locale]?
        private var tapAction: () -> Void
        private var menuItem: (Locale, Keyboard.LayoutType?) -> MenuItem
        
        public func body(content: Content) -> some View {
            if menuLocales.count > 1 {
                #if os(iOS) || os(macOS) || os(visionOS)
                Menu(content: {
                    ForEach(menuLocales) { menuLocale in
                        if let locale = menuLocale.locale {
                            Button(
                                action: { select(menuLocale) },
                                label: { menuItem(locale, menuLocale.layoutType) }
                            )
                            if isSelected(menuLocale) {
                                Divider()
                            }
                        }
                    }
                }, label: {
                    content
                }, primaryAction: tapAction)
                #else
                Button(action: tapAction) {
                    content
                }
                #endif
            } else {
                content
            }
        }
    }
}

private extension Locale.ContextMenu {
    
    var menuLocales: [Keyboard.AddedLocale] {
        let locales = menuLocalesRaw
        guard let selected = locales.first(where: isSelected) else { return locales }
        return [selected] + locales.filter { $0 != selected }
    }

    var menuLocalesRaw: [Keyboard.AddedLocale] {
        if let locales { return (locales.map { .init($0) }) }
        let useAdded = keyboardContext.enabledLocalesDataSource == .added
        if useAdded { return keyboardContext.settings.addedLocales }
        return keyboardContext.locales.map { .init($0) }
    }
    
    func isSelected(_ locale: Keyboard.AddedLocale) -> Bool {
        let currentLocale = keyboardContext.locale
        let currentLayout = keyboardContext.keyboardLayoutType
        return locale.locale == currentLocale && locale.layoutType == currentLayout
    }
    
    func select(_ addedLocale: Keyboard.AddedLocale) {
        guard let locale = addedLocale.locale else { return }
        keyboardContext.selectLocale(locale, layoutType: addedLocale.layoutType)
    }
}

public extension View {

    /// Apply a context menu that either lists a custom list
    /// of locales, or applicable locales from the `context`.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    func localeContextMenu(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            Locale.ContextMenu(
                keyboardContext: context,
                locales: locales,
                tapAction: tapAction
            )
        )
    }

    /// Apply a context menu that either lists a custom list
    /// of locales, or applicable locales from the `context`.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    ///   - menuItem: A menu item view builder.
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale, Keyboard.LayoutType?) -> ButtonView
    ) -> some View {
        self.modifier(
            Locale.ContextMenu(
                keyboardContext: context,
                locales: locales,
                tapAction: tapAction,
                menuItem: menuItem
            )
        )
    }
}

#Preview {

    struct Preview: View {

        @StateObject
        var context: KeyboardContext = {
            let context = KeyboardContext()
            context.locale = .swedish
            context.locales = .keyboardKitSupported
            context.localePresentationLocale = .english
            context.settings.addedLocales = [
                .init(.english, layoutType: nil),
                .init(.english, layoutType: .qwerty),
                .init(.finnish, layoutType: nil),
                .init(.english, layoutType: .azerty),
                .init(.swedish, layoutType: nil)
            ]
            return context
        }()

        var localeName: String {
            let contextLocale = context.localePresentationLocale
            let locale = contextLocale ?? context.locale
            return context.locale.localizedName(in: locale) ?? "-"
        }

        var body: some View {
            VStack {
                Text("🌐 \(localeName)")
                    .localeContextMenu(
                    for: context,
                    // locales: [.swedish],
                    tapAction: { }
                )
                Spacer()
                Button("Print locale") {
                    print(context.locale)
                }
            }
            .id(context.locale.identifier)
        }
    }

    return Preview()
}
