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
     Apply a context menu that lists all locales that are in
     the provided `context`.
     
     Selecting a locale in the menu will change the `locale`
     of the provided context.
     
     This function has no effect if the context doesn't have
     multiple locales.
     */
    @ViewBuilder
    func keyboardContextMenu<T, V: View>(items: [T], createMenuItem: @escaping (T) -> V) -> some View {
        if items.count < 2 {
            self
        } else {
            self.contextMenu(ContextMenu {
                ForEach(Array(items.enumerated()), id: \.offset) { (_, locale) in
                    createMenuItem(locale)
                }
            })
        }
    }
}
