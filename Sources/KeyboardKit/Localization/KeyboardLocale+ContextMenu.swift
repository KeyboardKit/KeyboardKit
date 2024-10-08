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
    /// ``SwiftUICore/View/keyboardLocaleContextMenu(for:locales:tapAction:)``
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
            locales: [KeyboardLocale]? = nil,
            tapAction: @escaping () -> Void
        ) where MenuItem == Text {
            self.init(
                keyboardContext: keyboardContext,
                locales: locales,
                tapAction: tapAction
            ) {
                Text($0.localizedName(in: keyboardContext.localePresentationLocale ?? $0))
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
            locales: [KeyboardLocale]? = nil,
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

        private var locales: [KeyboardLocale]?

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
        let customLocales = locales?.map { $0.locale }
        let locales = customLocales ?? contextLocales
        var filtered = locales
            .filter { $0.identifier != contextLocale.identifier }
        filtered.insert(contextLocale, at: 0)
        return filtered
    }

    func title(for locale: Locale) -> String {
        locale.localizedName(in: keyboardContext.localePresentationLocale ?? locale)
    }
}

public extension View {

    /// Apply a context menu that either lists all available
    /// locales in the ``KeyboardContext``, or a custom list.
    ///
    /// If you don't provide any locales, this menu will use
    /// the context ``KeyboardContext/addedLocales``, if any,
    /// else ``KeyboardContext/locales``.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    func keyboardLocaleContextMenu(
        for context: KeyboardContext,
        locales: [KeyboardLocale]? = nil,
        tapAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            KeyboardLocale.ContextMenu(
                keyboardContext: context,
                locales: locales,
                tapAction: tapAction
            )
        )
    }

    /// Apply a context menu that either lists all available
    /// locales in the ``KeyboardContext``, or a custom list.
    ///
    /// If you don't provide any locales, this menu will use
    /// the context ``KeyboardContext/addedLocales``, if any,
    /// else ``KeyboardContext/locales``.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    ///   - menuItem: A menu item view builder.
    func keyboardLocaleContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        locales: [KeyboardLocale]? = nil,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        self.modifier(
            KeyboardLocale.ContextMenu(
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
            context.keyboardLocale?.localizedName(in: .english) ?? "-"
        }

        var body: some View {
            VStack {
                Text("🌐 \(localeName)")
                    .keyboardLocaleContextMenu(
                    for: context,
                    // locales: [.swedish],
                    tapAction: { }
                )
                Button("Print locale") {
                    print(context.locale)
                }
            }
            .onAppear {
                context.locales = KeyboardLocale.allCases.map { $0.locale }
                context.addedLocales = [
                    // KeyboardLocale.arabic.locale,
                    // KeyboardLocale.mongolian.locale
                ]
                context.localePresentationLocale = KeyboardLocale.danish.locale
            }
            .id(context.locale.identifier)
        }
    }

    return Preview()
}
