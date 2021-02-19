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
import UIKit

extension KeyboardAction {
    
    static var testActions: [KeyboardAction] {
        [
            .none,
            .dismissKeyboard,
            .done,
            .character(""),
            .command,
            .control,
            .custom(name: ""),
            .dictation,
            .dismissKeyboard,
            .done,
            .emoji(Emoji("")),
            .emojiCategory(.smileys),
            .escape,
            .function,
            .go,
            .image(description: "", keyboardImageName: "", imageName: ""),
            
            .keyboardType(.alphabetic(.lowercased)),
            .keyboardType(.alphabetic(.uppercased)),
            .keyboardType(.alphabetic(.capsLocked)),
            .keyboardType(.numeric),
            .keyboardType(.symbolic),
            .keyboardType(.email),
            .keyboardType(.emojis),
            .keyboardType(.images),
            .keyboardType(.custom("")),
            
            .moveCursorBackward,
            .moveCursorForward,
            .newLine,
            .nextKeyboard,
            .nextLocale,
            .ok,
            .option,
            .return,
            .search,
            
            .shift(currentState: .lowercased),
            .shift(currentState: .uppercased),
            .shift(currentState: .capsLocked),
            
            .space,
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .tab
        ]
    }
}
