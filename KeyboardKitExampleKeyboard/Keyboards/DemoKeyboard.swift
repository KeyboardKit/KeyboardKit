//
//  DemoKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-14.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is used by the demo application keyboards and
 provides functionality that is shared between the keyboards.
 
 */

import KeyboardKit

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


// MARK: - Character Extensions

extension Sequence where Iterator.Element == [String] {
    
    func uppercased() -> [Iterator.Element] {
        return map { $0.map { $0.uppercased() } }
    }
    
    func mappedToActions() -> KeyboardActionRows {
        return map { $0.map { .character($0) } }
    }
}


// MARK: - Action Extensions

extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func appending(_ actions: KeyboardActionRow) -> KeyboardActionRows {
        var result = map { $0 }
        result.append(actions)
        return result
    }
}
