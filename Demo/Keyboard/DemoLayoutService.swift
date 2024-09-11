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

/// This service inherits the standard service, then makes a
/// few demo-specific adjustments to the standard layout.
class DemoLayoutService: KeyboardLayout.StandardService {

    init(extraKey: ExtraKey) {
        self.extraKey = extraKey
    }

    let extraKey: ExtraKey

    enum ExtraKey {
        case none
        case emojiIfNeeded
        case localeSwitcher
        case rocket
        case url
    }

    /// Insert a locale switcher action or a rocket button.
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        switch extraKey {
        case .none: break
        case .emojiIfNeeded: layout.tryInsertEmojiButton()
        case .localeSwitcher: layout.tryInsertLocaleSwitcher()
        case .rocket: layout.tryInsertRocketButton()
        case .url: layout.tryInsertUrlButton()
        }
        return layout
    }
}

private extension KeyboardLayout {

    func tryInsertEmojiButton() {
        guard let row = bottomRow else { return }
        let hasEmoji = row.contains(where: { $0.action == .keyboardType(.emojis) })
        if hasEmoji { return }
        guard let button = tryCreateBottomRowItem(for: .keyboardType(.emojis)) else { return }
        itemRows.insert(button, after: .space, atRow: bottomRowIndex)
    }

    func tryInsertLocaleSwitcher() {
        guard let item = tryCreateBottomRowItem(for: .nextLocale) else { return }
        itemRows.insert(item, after: .space, atRow: bottomRowIndex)
    }

    func tryInsertRocketButton() {
        guard let button = tryCreateBottomRowItem(for: .rocket) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }

    func tryInsertUrlButton() {
        let action = KeyboardAction.url(.init(string: "https://keyboardkit.com"), id: nil)
        guard let button = tryCreateBottomRowItem(for: action) else { return }
        itemRows.insert(button, before: .space, atRow: bottomRowIndex)
    }
}
