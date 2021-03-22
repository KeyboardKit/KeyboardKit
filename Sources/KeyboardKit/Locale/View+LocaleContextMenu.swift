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
     This applies a context menu that lists all locales that
     are in the provided context. Picking items in this menu
     changes the `locale` of the context.
     
     This function has no effect if the context doesn't have
     multiple locales.
     */
    @ViewBuilder
    func localeContextMenu(for context: KeyboardContext) -> some View {
        if context.locales.count < 2 {
            self
        } else {
            self.contextMenu(ContextMenu {
                ForEach(Array(context.locales.enumerated()), id: \.offset) { locale in
                    let locale = locale.element
                    let text = locale.localizedString(forIdentifier: locale.identifier) ?? "-"
                    Button(text.capitalized, action: { context.locale = locale })
                }
            })
        }
    }
}
