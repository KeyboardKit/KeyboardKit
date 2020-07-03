//
//  KeyboardInputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A "keyboard input set" represents the text input parts of a
 system keyboard, i.e. the lighter input keys.
 
 `TODO` It should be possible to initialize an input set for
 a supported locale. Implement this once we support multiple
 locales and this model has proven viable.
 */
public struct KeyboardInputSet {
    
    public let inputCharacters: [[String]]
}

public extension KeyboardInputSet {
    
    static var english: KeyboardInputSet {
        KeyboardInputSet(inputCharacters: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    static var englishNumeric: KeyboardInputSet {
        KeyboardInputSet(inputCharacters: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
            [".", ",", "?", "!", "´"]
        ])
    }
    
    static var englishSymbolic: KeyboardInputSet {
        KeyboardInputSet(inputCharacters: [
            ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
            ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
            [".", ",", "?", "!", "´"]
        ])
    }
}
