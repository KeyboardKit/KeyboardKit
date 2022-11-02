//
//  View+LocaleContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(macOS) || os(watchOS)
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
        self.localeContextMenu(for: context) { locale in
            Text(locale.localizedName)
        }
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
        self.localeContextMenu(locales: context.locales) { locale in
            Button(action: { context.locale = locale }, label: {
                buttonContentBuilder(locale)
            })
        }
    }
    
    /**
     Apply a locale context menu that lists all the provided
     `locales` and uses the `buttonViewBuilder` to create a view
     for each locale in the collection.
     
     The function only has effects if there are at least two
     locales in the provided collection.
     */
    @ViewBuilder
    func localeContextMenu<ButtonView: View>(
        locales: [Locale],
        buttonViewBuilder: @escaping (Locale) -> ButtonView
    ) -> some View {
        if locales.count < 2 {
            self
        } else {
            self.contextMenu(
                ContextMenu {
                    ForEach(locales, id: \.identifier) {
                        buttonViewBuilder($0)
                    }
                }
            )
        }
    }
}
#endif
