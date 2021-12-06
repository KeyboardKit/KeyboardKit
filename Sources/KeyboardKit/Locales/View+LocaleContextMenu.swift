//
//  View+LocaleContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a locale context menu that lists all locales in a
     `context` and uses the "localized and capitalized" name
     of each locale as the button content.
     
     This function will apply an action to each button, that
     changes the locale of the provided `context`.
     
     The function only hae effects if there are at least two
     locales in the provided collection.
     */
    @ViewBuilder
    func localeContextMenu(
        for context: KeyboardContext) -> some View {
        self.localeContextMenu(for: context) { locale in
            Text(locale.localizedName.capitalized)
        }
    }
    
    /**
     Apply a locale context menu that lists all locales in a
     `context` and uses the `buttonContentBuilder` to create
     a button label for each locale in the context.
     
     This function will apply an action to each button, that
     changes the locale of the provided `context`.
     
     The function only hae effects if there are at least two
     locales in the provided collection.
     */
    @ViewBuilder
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        buttonContentBuilder: @escaping (Locale) -> ButtonView) -> some View {
        self.localeContextMenu(locales: context.locales) { locale in
            Button(action: { context.locale = locale }) {
                buttonContentBuilder(locale)
            }
        }
    }
    
    /**
     Apply a locale context menu that lists all the provided
     `locales` and uses the `buttonBuilder` to create a view
     for each locale in the collection.
     
     This function can be used to create a completely custom
     context menu for a locale collection.
     
     The function only hae effects if there are at least two
     locales in the provided collection.
     */
    @ViewBuilder
    func localeContextMenu<ButtonView: View>(
        locales: [Locale],
        buttonBuilder: @escaping (Locale) -> ButtonView) -> some View {
        if locales.count < 2 {
            self
        } else {
            self.contextMenu(ContextMenu {
                ForEach(Array(locales.enumerated()), id: \.offset) {
                    buttonBuilder($0.element)
                }
            })
        }
    }
}
