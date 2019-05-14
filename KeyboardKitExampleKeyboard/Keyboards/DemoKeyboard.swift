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
        let needsSwitchKeyboard = inputViewController.needsInputModeSwitchKey
        let switcher: KeyboardAction = needsSwitchKeyboard ? .switchKeyboard : .switchToEmojiKeyboard
        return [leftmost, switcher, .space, .switchToEmojiKeyboard, .newLine]
    }
}
