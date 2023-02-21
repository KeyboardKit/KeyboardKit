//
//  LocaleContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view modifier can be used to add a locale context menu
 that changes the locale of the provided context.

 The easiest way to apply this view modifier is to apply the
 `.localeContextMenu(for:)` view extension to any view.

 Note that this view will only apply the context menu if the
 platform supports it and the context has multiple locales.
 */
public struct LocaleContextMenu<MenuItem: View>: ViewModifier {

    /**
     Create a context menu that lists all the locales in the
     context as a `Text` view with the full localized name.

     If no `presentationLocale` is provided, the locale text
     for each locale is localized with the locale itself.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - presentationLocale: The presentation locale to localize locales with, if any.
     */
    public init(
        keyboardContext: KeyboardContext,
        presentationLocale: Locale? = nil
    ) where MenuItem == Text {
        self.init(keyboardContext: keyboardContext) {
            Text($0.localizedName(in: presentationLocale ?? $0) ?? "-")
        }
    }

    /**
     Create a context menu that lists all the locales in the
     context as a `Text` view with the full localized name.

     If no `presentationLocale` is provided, the locale text
     for each locale is localized with the locale itself.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - presentationLocale: The presentation locale to localize locales with, if any.
     */
    public init(
        keyboardContext: KeyboardContext,
        presentationLocale locale: KeyboardLocale
    ) where MenuItem == Text {
        self.init(
            keyboardContext: keyboardContext,
            presentationLocale: locale.locale
        )
    }

    /**
     Create a context menu that lists all the locales in the
     context as custom views.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - menuItem: A menu item view builder.
     */
    public init(
        keyboardContext: KeyboardContext,
        @ViewBuilder menuItem: @escaping (Locale) -> MenuItem
    ) {
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.menuItem = menuItem
    }

    @ObservedObject
    private var keyboardContext: KeyboardContext

    private var menuItem: (Locale) -> MenuItem

    public func body(content: Content) -> some View {
        if keyboardContext.locales.count > 1 {
            content.withContextMenu(menu)
        } else {
            content
        }
    }
}

private extension View {

    func withContextMenu<MenuView: View>(_ menu: MenuView) -> some View {
        #if os(iOS) || os(macOS)
        self.contextMenu(
            ContextMenu { menu }
        )
        #else
        self
        #endif
    }
}

public extension LocaleContextMenu {

    var menu: some View {
        ForEach(keyboardContext.locales, id: \.identifier) { locale in
            Button(action: { keyboardContext.locale = locale }, label: {
                menuItem(locale)
            })
        }
    }
}

public extension View {

    /**
     Apply a menu that lists all the locales in the keyboard
     context as a `Text` view with the full localized name.

     If no `presentationLocale` is provided, the locale text
     for each locale is localized with the locale itself.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - presentationLocale: The presentation locale to localize locales with, if any.
     */
    func localeContextMenu(
        for context: KeyboardContext,
        presentationLocale: Locale? = nil
    ) -> some View {
        self.modifier(
            LocaleContextMenu(
                keyboardContext: context,
                presentationLocale: presentationLocale
            )
        )
    }

    /**
     Apply a menu that lists all the locales in the keyboard
     context as a `Text` view with the full localized name.

     If no `presentationLocale` is provided, the locale text
     for each locale is localized with the locale itself.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - presentationLocale: The presentation locale to localize locales with, if any.
     */
    func localeContextMenu(
        for context: KeyboardContext,
        presentationLocale locale: KeyboardLocale
    ) -> some View {
        self.modifier(
            LocaleContextMenu(
                keyboardContext: context,
                presentationLocale: locale.locale
            )
        )
    }

    /**
     Apply a menu that lists all the locales in the keyboard
     context as custom views.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - menuItem: A menu item view builder.
     */
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        self.modifier(
            LocaleContextMenu(
                keyboardContext: context,
                menuItem: menuItem
            )
        )
    }
}

struct LocaleContextMenu_Previews: PreviewProvider {

    static let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locales = KeyboardLocale.allCases.map { $0.locale }
        return context
    }()

    static var previews: some View {
        VStack(spacing: 20) {
            Text("🌐")
                .localeContextMenu(for: context)
            Text("🌐 (in Swedish)")
                .localeContextMenu(for: context, presentationLocale: .swedish)
        }
    }
}
