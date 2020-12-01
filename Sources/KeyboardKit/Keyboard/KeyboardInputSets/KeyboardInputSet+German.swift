//
//  KeyboardInputSet+German.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardInputSet {
    
    static var germanAlphabetic: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "z", "u", "i", "o", "p", "ü"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
            ["y", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    static var germanNumeric: NumericKeyboardInputSet {
        NumericKeyboardInputSet(inputRows: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "€", "&", "@", "\""],
            [".", ",", "?", "!", "´"]
        ])
    }
    
    static var germanSymbolic: SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(inputRows: [
            ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
            ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
            [".", ",", "?", "!", "´"]
        ])
    }
}
