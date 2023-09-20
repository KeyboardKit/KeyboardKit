//
//  KeyboardAction+Test.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

extension KeyboardAction {
    
    static var testActions: [KeyboardAction] {
        [
            .none,
            .dismissKeyboard,
            .character(""),
            .characterMargin(""),
            .command,
            .control,
            .custom(named: ""),
            .dictation,
            .dismissKeyboard,
            .emoji(Emoji("")),
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
            .nextKeyboard,
            .nextLocale,
            .option,
            .primary(.done),
            .primary(.go),
            .primary(.newLine),
            .primary(.ok),
            .primary(.search),
            .primary(.return),
            
            .shift(currentCasing: .lowercased),
            .shift(currentCasing: .uppercased),
            .shift(currentCasing: .capsLocked),
            
            .space,
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .systemSettings,
            .tab,
            .url(URL(string: ""))
        ]
    }
}
