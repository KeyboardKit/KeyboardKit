//
//  DemoKeyboardLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific layout provider appends a "locale picker"
 next to the space bar.
 */
class DemoKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        guard context.locales.count > 1 else { return layout }
        guard var lastRow = layout.items.last else { return layout }
        var items = Array(layout.items.dropLast())
        guard let system = (lastRow.first { $0.action.isSystemAction }) else { return layout }
        let switcher = KeyboardLayoutItem(action: .nextLocale, size: system.size, insets: system.insets)
        lastRow.insert(switcher, at: lastRow.count - 1)
        items.append(lastRow)
        return KeyboardLayout(items: items)
    }
}
