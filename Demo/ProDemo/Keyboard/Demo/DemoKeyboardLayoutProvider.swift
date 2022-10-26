//
//  DemoKeyboardLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro

/**
 This layout provider adds a locale picker next to space, if
 KeyboardKit is setup with many locales. This means that the
 provider lets you to try out all KeyboardKit Pro locales in
 a single keyboard. For the non-pro demo, just can add a few
 locales to see this in action.

 The provider is registered by ``KeyboardViewController`` to
 show how to register a custom layout provider and use it to
 customize the keyboard layout.
 */
class DemoKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        guard layout.hasRows && context.hasMultipleLocales else { return layout }
        layout.tryInsertLocaleSwitcher()
        return layout
    }
}

private extension KeyboardContext {

    var hasMultipleLocales: Bool {
        locales.count > 1
    }
}

private extension KeyboardLayout {

    var bottomRowIndex: Int {
        itemRows.count - 1
    }

    var hasRows: Bool {
        itemRows.count > 0
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
