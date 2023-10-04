//
//  DemoLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific provider inherits the standard one, then
 adds a rocket and a locale key around the space key.
 */
class DemoLayoutProvider: StandardKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        layout.tryInsertRocketButton()
        layout.tryInsertLocaleSwitcher(for: context)
        return layout
    }
}

private extension KeyboardLayout {
    
    func tryInsertLocaleSwitcher(for context: KeyboardContext) {
        guard context.hasMultipleLocales else { return }
        guard let button = tryCreateBottomRowItem(for:  .nextLocale) else { return }
        itemRows.insert(button, after: .space, atRow: bottomRowIndex)
    }
    
    func tryInsertRocketButton() {
        guard let button = tryCreateBottomRowItem(for:  .character("🚀")) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }
}
