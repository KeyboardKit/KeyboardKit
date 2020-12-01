//
//  KeyboardInputSet+English.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardInputSet {
    
    static var alphabetic_en: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    static var numeric_en: NumericKeyboardInputSet {
        NumericKeyboardInputSet(inputRows: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
            [".", ",", "?", "!", "´"]
        ])
    }
    
    static var symbolic_en: SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(inputRows: [
            ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
            ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
            [".", ",", "?", "!", "´"]
        ])
    }
}
