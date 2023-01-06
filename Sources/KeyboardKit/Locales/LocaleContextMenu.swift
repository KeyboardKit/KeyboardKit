//
//  LocaleContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

/**
 This view modifier applies a context menu, that can be used
 to change the locale of a certain ``KeyboardContext``.

 The easiest way to apply this view modifier is by using the
 `.localeContextMenu(for:)` view extension.

 Note that the modifier will not apply a context menu if the
 context only has a single locale.
 */
public struct LocaleContextMenu<MenuItem: View>: ViewModifier {

    public init(
        keyboardContext: KeyboardContext
    ) where MenuItem == Text {
        self.init(keyboardContext: keyboardContext) {
            Text($0.localizedName.capitalized())
        }
    }

    public init(
        keyboardContext: KeyboardContext,
        menuItem: @escaping (Locale) -> MenuItem
    ) {
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.menuItem = menuItem
    }

    @ObservedObject
    private var keyboardContext: KeyboardContext

    private var menuItem: (Locale) -> MenuItem

    public func body(content: Content) -> some View {
        if keyboardContext.locales.count > 1 {
            content.contextMenu(
                ContextMenu {
                    menu
                }
            )
        } else {
            content
        }
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
     Apply a locale context menu that lists all locales in a
     `context` and uses the localized name of each locale as
     the button content.

     The function only has effects if there are at least two
     locales in the provided collection.
     */
    func localeContextMenu(
        for context: KeyboardContext
    ) -> some View {
        self.modifier(LocaleContextMenu(
            keyboardContext: context)
        )
    }

    /**
     Apply a locale context menu that lists all locales in a
     `context` and uses the `buttonContentBuilder` to create
     a button label for each locale in the context.

     The function only has effects if there are at least two
     locales in the provided collection.
     */
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        buttonContentBuilder: @escaping (Locale) -> ButtonView
    ) -> some View {
        self.modifier(LocaleContextMenu(
            keyboardContext: context,
            menuItem: buttonContentBuilder)
        )
    }
}
#endif
