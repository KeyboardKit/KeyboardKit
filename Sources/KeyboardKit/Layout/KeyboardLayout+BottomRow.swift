//
//  KeyboardLayout+BottomRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {
    
    /// Get the bottom item row index.
    var bottomRowIndex: Int {
        itemRows.count - 1
    }

    /// Get the system action items at the bottom row.
    var bottomRowSystemItems: [KeyboardLayout.Item] {
        if bottomRowIndex < 0 { return [] }
        return itemRows[bottomRowIndex].filter {
            $0.action.isSystemAction
        }
    }

    /**
     Get the bottom row system items.

     This function will use the first ``bottomRowSystemItems``
     as item template if you don't provide a template. If no
     template is found, the function will return `nil` since
     it lacks information to create a valid item.
     */
    func tryCreateBottomRowItem(
        for action: KeyboardAction
    ) -> KeyboardLayout.Item? {
        guard let template = bottomRowSystemItems.first else { return nil }
        return KeyboardLayout.Item(
            action: action,
            size: template.size,
            edgeInsets: template.edgeInsets
        )
    }
}
