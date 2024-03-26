//
//  DemoLayoutProvider.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

/// This demo-specific provider inherits a standard provider
/// and adds a locale button next to space.
///
/// The ``KeyboardViewController`` shows how you can replace
/// the standard provider with this custom one.
///
/// The locale button is only added if the keyboard has many
/// locales.
class DemoLayoutProvider: StandardKeyboardLayoutProvider {

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
