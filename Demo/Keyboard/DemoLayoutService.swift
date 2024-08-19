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
class DemoLayoutService: KeyboardLayout.StandardService {

    init(_ extraKey: ExtraKey) {
        self.extraKey = extraKey
    }

    let extraKey: ExtraKey

    enum ExtraKey {
        case none, rocket, localeSwitcher
    }

    /// Insert a locale switcher action or a rocket button.
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        switch extraKey {
        case .none: break
        case .rocket: layout.tryInsertRocketButton()
        case .localeSwitcher: layout.tryInsertLocaleSwitcher()
        }
        return layout
    }
}

private extension KeyboardLayout {
    
    func tryInsertLocaleSwitcher() {
        guard let item = tryCreateBottomRowItem(for: .nextLocale) else { return }
        itemRows.insert(item, after: .space, atRow: bottomRowIndex)
    }

    func tryInsertRocketButton() {
        guard let button = tryCreateBottomRowItem(for:  .rocket) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }
}
