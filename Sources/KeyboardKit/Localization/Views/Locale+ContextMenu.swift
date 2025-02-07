//
//  Locale+ContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Locale {
    
    /// This view modifier can be used to add locale context
    /// menus to any.
    ///
    /// Use ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)``
    /// as a convenience modifier to apply this menu, if the
    /// provided locales or ``KeyboardContext/enabledLocales``
    /// have at least two locales. It will sort and localize
    /// the list with ``KeyboardContext/localePresentationLocale``.
    ///
    /// The ``KeyboardView`` automatically applies this menu
    /// to ``KeyboardAction/nextLocale``, so you do not have
    /// to do it manually when using that view.
    struct ContextMenu<MenuItem: View>: ViewModifier {
        
        /// Create a menu that lists locales as `Text` views
        /// with the full localized name.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: The explicit locales to list, if any.
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
            ) {
                let contextLocale = keyboardContext.localePresentationLocale
                let locale = contextLocale ?? $0
                Text($0.localizedName(in: locale) ?? $0.identifier)
            }
        }
        
        /// Create a menu that lists locales as custom views.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: The explicit locales to list, if any.
        ///   - tapAction: The action to trigger when the view is tapped.
        ///   - menuItem: A menu item view builder.
        public init(
            keyboardContext: KeyboardContext,
            locales: [Locale]? = nil,
            tapAction: @escaping () -> Void,
            @ViewBuilder menuItem: @escaping (Locale) -> MenuItem
        ) {
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
            self.locales = locales
            self.tapAction = tapAction
            self.menuItem = menuItem
        }
        
        @ObservedObject
        private var keyboardContext: KeyboardContext

        private var locales: [Locale]?
        private var tapAction: () -> Void
        private var menuItem: (Locale) -> MenuItem
        
        public func body(content: Content) -> some View {
            if menuLocales.count > 1 {
                #if os(iOS) || os(macOS) || os(visionOS)
                Menu(content: {
                    ForEach(menuLocales, id: \.identifier) { locale in
                        Button(
                            action: { keyboardContext.locale = locale },
                            label: { menuItem(locale) }
                        )
                        if keyboardContext.locale == locale {
                            Divider()
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

    var menuLocales: [Locale] {
        let context = keyboardContext
        let presentationLocale = context.localePresentationLocale
        let result = self.locales ?? context.enabledLocales
        return result.sorted(in: presentationLocale, insertFirst: context.locale)
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
        menuItem: @escaping (Locale) -> ButtonView
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
            context.locales = .keyboardKitSupported
            context.localePresentationLocale = nil // .english
            context.settings.addedLocales = .keyboardKitSupported
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
