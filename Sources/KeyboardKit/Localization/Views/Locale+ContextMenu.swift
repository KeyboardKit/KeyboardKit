//
//  Locale+ContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Locale {
    
    /// This view modifier can apply locale context menus to
    /// any view.
    ///
    /// The easiest way to apply this modifier is to use the
    /// ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)``
    /// modifier. The ``KeyboardView`` automatically applies
    /// it to the ``KeyboardAction/nextLocale`` action.
    ///
    /// The menu sorts and localizes the listed locales with
    /// the ``KeyboardContext/localePresentationLocale``.
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
                Text($0.localizedName(in: keyboardContext.localePresentationLocale ?? $0) ?? "")
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
            if keyboardContext.locales.count > 1 {
                content.withContextMenu(
                    menu,
                    keyboardContext: keyboardContext,
                    tapAction: tapAction
                )
            } else {
                content
            }
        }
    }
}

private extension View {

    @ViewBuilder
    func withContextMenu<MenuView: View>(
        _ menu: MenuView,
        keyboardContext: KeyboardContext,
        tapAction: @escaping () -> Void
    ) -> some View {
        #if os(iOS) || os(macOS) || os(visionOS)
        Menu(content: {
            menu
        }, label: {
            self
        }, primaryAction: tapAction)
        #else
        self
        #endif
    }
}

private extension Locale.ContextMenu {

    var menu: some View {
        ForEach(menuLocales, id: \.identifier) { locale in
            Button(
                action: { keyboardContext.locale = locale },
                label: { menuItem(locale) }
            )
            if keyboardContext.locale == locale {
                Divider()
            }
        }
    }

    var menuLocales: [Locale] {
        let context = keyboardContext
        let contextLocale = context.locale
        let contextLocales = context.selectableLocales
        let customLocales = self.locales
        let locales = customLocales ?? contextLocales
        var filtered = locales
            .filter { $0.identifier != contextLocale.identifier }
        filtered.insert(contextLocale, at: 0)
        return filtered
    }

    func title(for locale: Locale) -> String {
        locale.localizedName(
            in: keyboardContext.localePresentationLocale ?? locale
        ) ?? ""
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

        @State
        var context = KeyboardContext()

        var localeName: String {
            context.locale.localizedName(in: .english) ?? "-"
        }

        var body: some View {
            VStack {
                Text("🌐 \(localeName)")
                    .localeContextMenu(
                    for: context,
                    // locales: [.swedish],
                    tapAction: { }
                )
                Button("Print locale") {
                    print(context.locale)
                }
            }
            .onAppear {
                context.locales = .keyboardKitSupported
                context.settings.addedLocales = [
                    // .arabic,
                    // .mongolian
                ]
                context.localePresentationLocale = .danish
            }
            .id(context.locale.identifier)
        }
    }

    return Preview()
}
