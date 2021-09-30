//
//  KeyboardAction+Test.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

extension KeyboardAction {
    
    static var testActions: [KeyboardAction] {
        [
            .none,
            .dismissKeyboard,
            .character(""),
            .command,
            .control,
            .custom(named: ""),
            .dictation,
            .dismissKeyboard,
            .emoji(Emoji("")),
            .emojiCategory(.smileys),
            .escape,
            .function,
            .image(description: "", keyboardImageName: "", imageName: ""),
            
            .keyboardType(.alphabetic(.lowercased)),
            .keyboardType(.alphabetic(.uppercased)),
            .keyboardType(.alphabetic(.capsLocked)),
            .keyboardType(.numeric),
            .keyboardType(.symbolic),
            .keyboardType(.email),
            .keyboardType(.emojis),
            .keyboardType(.images),
            .keyboardType(.custom(named: "")),
            
            .moveCursorBackward,
            .moveCursorForward,
            .newLine,
            .nextKeyboard,
            .nextLocale,
            .option,
            .primary(.done),
            .primary(.go),
            .primary(.newLine),
            .primary(.ok),
            .primary(.search),
            .return,
            
            .shift(currentState: .lowercased),
            .shift(currentState: .uppercased),
            .shift(currentState: .capsLocked),
            
            .space,
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .tab
        ]
    }
}
