//
//  KeyboardInputSet+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This file contains `KeyboardInputSet`s for various locales.
 */
public extension KeyboardInputSet {
    
    
    // MARK: - Alphabetic
    
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
    
    
    // MARK: - Numeric
    
    static var numeric_de: NumericKeyboardInputSet {
        numeric_eu
    }
    
    static var numeric_en: NumericKeyboardInputSet {
        standardNumeric(currency: "$")
    }
    
    static var numeric_eu: NumericKeyboardInputSet {
        standardNumeric(currency: "€")
    }
    
    static var numeric_it: NumericKeyboardInputSet {
        numeric_eu
    }
    
    static var numeric_sv: NumericKeyboardInputSet {
        standardNumeric(currency: "kr")
    }
    
    
    // MARK: - Symbolic
    
    static var symbolic_de: SymbolicKeyboardInputSet {
        symbolic_eu
    }
    
    static var symbolic_en: SymbolicKeyboardInputSet {
        standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"])
    }
    
    static var symbolic_eu: SymbolicKeyboardInputSet {
        standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "$", "£", "¥", "•"])
    }
    
    static var symbolic_it: SymbolicKeyboardInputSet {
        symbolic_eu
    }
    
    static var symbolic_sv: SymbolicKeyboardInputSet {
        standardSymbolic(center: ["_", "\\", "|", "~", "<", ">", "€", "$", "£", "•"])
    }
}


// MARK: - Standard

public extension KeyboardInputSet {
    
    static func standardNumeric(currency: String) -> NumericKeyboardInputSet {
        NumericKeyboardInputSet(inputRows: [
            standardNumericTop,
            ["-", "/", ":", ";", "(", ")", currency, "&", "@", "\""],
            standardNumericBottom
        ])
    }
    
    static var standardNumericTop: [String] {
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    }
    
    static var standardNumericBottom: [String] {
        [".", ",", "?", "!", "´"]
    }
    
    static func standardSymbolic(center: [String]) -> SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(inputRows: [
            standardSymbolicTop,
            center,
            standardSymbolicBottom
        ])
    }
    
    static var standardSymbolicTop: [String] {
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="]
    }
    
    static var standardSymbolicBottom: [String] {
        standardNumericBottom
    }
}
