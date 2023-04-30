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
        // layout.tryInsertDictationButton()
        guard context.locales.count > 1 else { return layout }
        layout.tryInsertLocaleSwitcher()
        return layout
    }
}

private extension KeyboardLayout {

    func tryInsertDictationButton() {
        guard let item = tryCreateBottomRowItem(for: .dictation) else { return }
        itemRows.insert(item, after: .space, atRow: bottomRowIndex)
    }

    func tryInsertLocaleSwitcher() {
        guard let item = tryCreateBottomRowItem(for: .nextLocale) else { return }
        itemRows.insert(item, after: .space, atRow: bottomRowIndex)
    }
}
