//
//  DemoLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/// This provider inherits the standard provider, then makes
/// demo-specific adjustments to the standard layout.
///
/// The provider will inject a rocket button into the layout.
///
/// You can play around with the class to see how it affects
/// the demo keyboard.
///
/// The ``KeyboardViewController`` shows how you can replace
/// the standard provider with this custom one.
class DemoLayoutProvider: KeyboardLayout.StandardProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        layout.tryInsertRocketButton()
        return layout
    }
}

private extension KeyboardLayout {
    
    func tryInsertRocketButton() {
        guard let button = tryCreateBottomRowItem(for:  .rocket) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }
}
