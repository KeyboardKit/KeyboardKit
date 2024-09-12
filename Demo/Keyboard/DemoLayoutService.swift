//
//  DemoLayoutService.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#elseif IS_KEYBOARDKITPRO
import KeyboardKitPro
#endif

/// This service inherits the standard service, and can then
/// add one extra button before the spacebar.
class DemoLayoutService: KeyboardLayout.StandardService {

    init(extraKey: ExtraKey) {
        self.extraKey = extraKey
    }

    let extraKey: ExtraKey

    enum ExtraKey {
        case none
        case emojiIfNeeded
        case keyboardSwitcher
        case localeSwitcher
        case rocket
        case url(String)
    }

    /// Insert a locale switcher action or a rocket button.
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        switch extraKey {
        case .none: break
        case .emojiIfNeeded: layout.tryInsert(.keyboardType(.emojis))
        case .keyboardSwitcher: layout.tryInsert(.nextKeyboard)
        case .localeSwitcher: layout.tryInsert(.nextKeyboard)
        case .rocket: layout.tryInsert(.nextKeyboard)
        case .url(let string): layout.tryInsert(.url(.init(string: string), id: nil))
        }
        return layout
    }
}

private extension KeyboardLayout {

    func tryInsert(_ action: KeyboardAction) {
        guard let item = tryCreateBottomRowItem(for: action) else { return }
        itemRows.insert(item, before: .space, atRow: bottomRowIndex)
    }
}
