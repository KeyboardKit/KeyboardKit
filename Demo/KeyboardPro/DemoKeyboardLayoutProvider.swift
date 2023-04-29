//
//  DemoKeyboardLayoutProvider.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

/**
 This demo-specific appearance inherits the standard one and
 adds a locale button next to space.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom layout provider.

 The locale button is only be added if the keyboard has many
 locales. The KeyboardKit Pro demo automatically sets up the
 keyboard with all locales that are available in the license.
 */
class DemoKeyboardLayoutProvider: StandardKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        guard context.locales.count > 1 else { return layout }
        layout.tryInsertLocaleSwitcher()
        return layout
    }
}

private extension KeyboardLayout {

    var bottomRowIndex: Int {
        itemRows.count - 1
    }

    var localeSwitcherTemplate: KeyboardLayoutItem? {
        itemRows[bottomRowIndex].first { $0.action.isSystemAction }
    }

    func tryInsertLocaleSwitcher() {
        guard let template = localeSwitcherTemplate else { return }
        let switcher = KeyboardLayoutItem(action: .nextLocale, size: template.size, insets: template.insets)
        itemRows.insert(switcher, after: .space, atRow: bottomRowIndex)
    }
}
