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
        in viewController: KeyboardViewController) -> KeyboardActionRow {
        let needsSwitchKeyboard = viewController.needsInputModeSwitchKey
        let includeEmojiAction = viewController.keyboardMode != .emojis
        let emojiAction = KeyboardAction.switchToEmojiKeyboard
        let switcher: KeyboardAction = needsSwitchKeyboard ? .switchKeyboard : emojiAction
        let actions = [leftmost, switcher, .space, emojiAction, .newLine]
        return includeEmojiAction ? actions : actions.filter { $0 != emojiAction }
    }
}
