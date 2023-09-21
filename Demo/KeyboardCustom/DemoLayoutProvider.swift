//
//  DemoLayoutProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This demo provider inherits the standard provider and makes
 it replace the alphabetic input keys with custom ones.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom layout provider.
 */
class DemoLayoutProvider: StandardKeyboardLayoutProvider {
    
    init() {
        super.init(
            baseProvider: EnglishKeyboardLayoutProvider(
                alphabeticInputSet: .init(rows: [
                    .init(chars: "KEYBOARD"),
                    .init(chars: "KIT"),
                    .init(chars: "YEAH!")
                ])
            )
        )
    }

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        let widerItem = KeyboardLayout.Item(
            action: .character("I"),
            size: .init(
                width: .inputPercentage(2),
                height: layout.idealItemHeight),
            edgeInsets: layout.idealItemInsets)
        layout.itemRows.replace(.character("I"), with: widerItem)
        return layout
    }
}
