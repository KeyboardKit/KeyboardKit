//
//  SymbolicKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the default symbolic keyboard for iOS,
 just like `AlphabeticKeyboard` mimics the alphabetic one.
 
 */

import KeyboardKit

struct SymbolicKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        actions = type(of: self).actions(in: viewController)
    }
    
    let actions: [[KeyboardAction]]
    
    static private(set) var characters: [[String]] = [
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
        ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
        [".", ",", "?", "!", "´"]
    ]
}

private extension SymbolicKeyboard {
    
    static func actions(in viewController: KeyboardViewController) -> KeyboardActionRows {
        let leftmost = KeyboardAction.switchToKeyboard(.alphabetic(uppercased: false))
        return characters
            .mappedToActions()
            .addingSideActions()
            .appending(bottomActions(leftmost: leftmost, for: viewController))
    }
}

private extension Sequence where Iterator.Element == [KeyboardAction] {
    
    func addingSideActions() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.switchToKeyboard(.numeric), at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
}
