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

    /// Try to create a bottom row item.
    ///
    /// This uses the first ``bottomRowSystemItems`` item as
    /// template, if you don't provide an action. If none is
    /// found, the function returns `nil`.
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
