//
//  KeyboardLayout+Switcher.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {
    
    /// Whether or not the layout has a certain switcher.
    func hasKeyboardSwitcher(_ type: Keyboard.KeyboardType) -> Bool {
        itemRows.hasKeyboardSwitcher(type)
    }
}

public extension KeyboardLayout.ItemRows {
    
    /// Whether or not the rows have a certain switcher.
    func hasKeyboardSwitcher(
        _ type: Keyboard.KeyboardType
    ) -> Bool {
        contains { $0.hasKeyboardSwitcher(type) }
    }
}

public extension KeyboardLayout.ItemRow {
    
    /// Whether or not the row has a certain switcher.
    func hasKeyboardSwitcher(
        _ type: Keyboard.KeyboardType
    ) -> Bool {
        contains { $0.action.isKeyboardTypeAction(type) }
    }
}
