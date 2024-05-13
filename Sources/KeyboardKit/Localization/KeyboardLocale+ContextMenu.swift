//
//  KeyboardLocale+ContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardLocale {
    
    /// This view modifier can apply keyboard locale context
    /// menus to any view.
    ///
    /// The easiest way to apply this modifier is to use the
    /// ``SwiftUI/View/keyboardLocaleContextMenu(for:tapAction:)``
    /// modifier, which the ``SystemKeyboard`` automatically
    /// applies for the ``KeyboardAction/nextLocale`` action,
    /// if the keyboard context has many locales.
    ///
    /// The menu sorts and localizes the listed locales with
    /// the ``KeyboardContext/localePresentationLocale``.
    struct ContextMenu<MenuItem: View>: ViewModifier {
        
        /// Create a menu that lists locales as `Text` views
        /// with the full localized name.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - tapAction: The action to trigger when the view is tapped.
        public init(
            keyboardContext: KeyboardContext,
            tapAction: @escaping () -> Void
        ) where MenuItem == Text {
            self.init(
                keyboardContext: keyboardContext,
                tapAction: tapAction
            ) {
                Text($0.localizedName(in: keyboardContext.localePresentationLocale ?? $0))
            }
        }
        
        /// Create a menu that lists locales as custom views.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - tapAction: The action to trigger when the view is tapped.
        ///   - menuItem: A menu item view builder.
        public init(
            keyboardContext: KeyboardContext,
            tapAction: @escaping () -> Void,
            @ViewBuilder menuItem: @escaping (Locale) -> MenuItem
        ) {
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
            self.tapAction = tapAction
            self.menuItem = menuItem
        }
        
        @ObservedObject
        private var keyboardContext: KeyboardContext
        
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
        #if os(iOS) || os(macOS)
        if #available(iOS 15.0, macOS 12.0, *) {
            Menu(content: {
                menu
            }, label: {
                self
            }, primaryAction: tapAction)
        } else {
            Button(action: tapAction) {
                self
            }.contextMenu(ContextMenu { menu })
        }
        #else
        self
        #endif
    }
}

private extension KeyboardLocale.ContextMenu {

    var locales: [Locale] {
        let locale = keyboardContext.locale
        var locales = keyboardContext.locales
            .filter { $0.identifier != locale.identifier }
        locales.insert(locale, at: 0)
        return locales
    }

    var menu: some View {
        ForEach(locales, id: \.identifier) { locale in
            Button(
                action: { keyboardContext.locale = locale },
                label: { menuItem(locale) }
            )
            if keyboardContext.locale == locale {
                Divider()
            }
        }
    }

    func title(for locale: Locale) -> String {
        locale.localizedName(in: keyboardContext.localePresentationLocale ?? locale)
    }
}

public extension View {

    /// Apply a menu that lists locales as `Text` views with
    /// the full localized name.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - tapAction: The action to trigger when the view is tapped.
    func keyboardLocaleContextMenu(
        for context: KeyboardContext,
        tapAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            KeyboardLocale.ContextMenu(
                keyboardContext: context,
                tapAction: tapAction
            )
        )
    }

    /// Apply a menu that lists locales as custom views.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - tapAction: The action to trigger when the view is tapped.
    ///   - menuItem: A menu item view builder.
    func keyboardLocaleContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        self.modifier(
            KeyboardLocale.ContextMenu(
                keyboardContext: context,
                tapAction: tapAction,
                menuItem: menuItem
            )
        )
    }
}

#Preview {

    let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locales = KeyboardLocale.allCases.map { $0.locale }
        context.localePresentationLocale = KeyboardLocale.danish.locale
        return context
    }()

    return VStack(spacing: 20) {
        Text("🌐").keyboardLocaleContextMenu(
            for: context,
            tapAction: {}
        )
    }
}
