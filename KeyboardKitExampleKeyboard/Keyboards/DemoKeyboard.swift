//
//  DemoKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-14.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

protocol DemoKeyboard {}

extension DemoKeyboard {
    
    static func bottomActions(
        leftmost: KeyboardAction,
        for idiom: UIUserInterfaceIdiom,
        in inputViewController: UIInputViewController) -> KeyboardActionRow {
        let actions = [leftmost, .switchKeyboard, .space, .switchToEmojiKeyboard, .newLine]
        let needs = inputViewController.needsInputModeSwitchKey
        return needs ? actions : actions.filter { $0 != .switchToEmojiKeyboard }
    }
}
