//
//  DemoKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-14.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit


/**
 
 This protocol is used by the demo application keyboards and
 provides shared functionality. These keyboards are for demo
 purposes, so they lack some functionality, like adapting to
 other languages, device types etc.
 
 */
protocol DemoKeyboard {}

extension DemoKeyboard {
    
    static func bottomActions(
        leftmost: KeyboardAction,
        for viewController: KeyboardViewController) -> KeyboardActionRow {
        let includeEmojiAction = viewController.keyboardType != .emojis
        let switcher = viewController.keyboardSwitcherAction
        let actions = [leftmost, switcher, .space, .switchToKeyboard(.emojis), .newLine]
        return includeEmojiAction ? actions : actions.filter { $0 != .switchToKeyboard(.emojis) }
    }
}
