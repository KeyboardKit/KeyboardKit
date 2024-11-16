//
//  DemoLayoutService.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

/// This service inherits the standard service, and can then
/// add one extra button before or after the spacebar.
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
        var layout = super.keyboardLayout(for: context)
        if context.isKeyboardFloating { return layout }     // We remove special keys due to the limited space

        switch extraKey {
        case .none: break
        case .emojiIfNeeded: layout.tryInsertEmojiButton()
        case .keyboardSwitcher: layout.tryInsert(.nextKeyboard)
        case .localeSwitcher: layout.tryInsert(.nextLocale)
        case .rocket: layout.tryInsert(.rocket)
        case .url(let string): layout.tryInsert(.url(.init(string: string), id: nil))
        }
        return layout
    }
}

private extension KeyboardLayout {

    mutating func tryInsert(_ action: KeyboardAction) {
        guard let item = tryCreateBottomRowItem(for: action) else { return }
        itemRows.insert(item, before: .space, inRow: bottomRowIndex)
    }

    mutating func tryInsertEmojiButton() {
        guard let row = bottomRow else { return }
        let hasEmoji = row.contains(where: { $0.action == .keyboardType(.emojis) })
        if hasEmoji { return }
        guard let button = tryCreateBottomRowItem(for: .keyboardType(.emojis)) else { return }
        itemRows.insert(button, after: .space, inRow: bottomRowIndex)
    }
}
