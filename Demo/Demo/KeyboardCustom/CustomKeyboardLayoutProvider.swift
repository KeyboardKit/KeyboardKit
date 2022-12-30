//
//  CustomKeyboardLayoutProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This class inherits ``DemoKeyboardLayoutProvider`` and adds
 a custom size to the "i" in the second row's "kit".

 Customizing a keyboard layout is currently quite cumbersome,
 since the `StandardKeyboardLayoutProvider` is made up of an
 iPhone- and an iPad-specific provider, which makes it quite
 hard to customize item sizes, replace buttons etc. The demo
 and its custom input set and layout will be used when these
 things will be made easier to achieve over time.
 */
class CustomKeyboardLayoutProvider: DemoKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        let widerItem = KeyboardLayoutItem(
            action: .character("I"),
            size: KeyboardLayoutItemSize(
                width: .inputPercentage(2),
                height: layout.idealItemHeight),
            insets: layout.idealItemInsets)
        layout.itemRows.replace(.character("I"), with: widerItem)
        return layout
    }
}
