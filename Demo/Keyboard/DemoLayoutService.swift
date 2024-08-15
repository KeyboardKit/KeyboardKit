//
//  DemoLayoutService.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/// This service inherits the standard service, then makes a
/// few demo-specific adjustments to the standard layout.
///
/// This service will inject a rocket button into the layout.
/// You can fiddle it to see how it affects the layout.
///
/// The ``KeyboardViewController`` shows how you can replace
/// the standard service with this custom one.
class DemoLayoutService: KeyboardLayout.StandardService {

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
