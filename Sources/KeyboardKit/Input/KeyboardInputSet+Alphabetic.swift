//
//  KeyboardInputSet+Alphabetic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This file contains various alphabetic input sets.
 */
public extension KeyboardInputSet {
    
    static var alphabetic_de: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "z", "u", "i", "o", "p", "ü"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
            ["y", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    static var alphabetic_en: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    static var alphabetic_it: AlphabeticKeyboardInputSet {
        alphabetic_en
    }
    
    static var alphabetic_sv: AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ])
    }
}
