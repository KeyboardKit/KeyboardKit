//
//  EnglishKeyboardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides English keyboard input sets.
 */
public class EnglishKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init() {}
    
    public func alphabeticInputSet(for context: KeyboardContext) -> AlphabeticKeyboardInputSet {
        AlphabeticKeyboardInputSet(inputRows: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ])
    }
    
    public func numericInputSet(for context: KeyboardContext) -> NumericKeyboardInputSet {
        .standard(currency: "$")
    }
    
    public func symbolicInputSet(for context: KeyboardContext) -> SymbolicKeyboardInputSet {
        .standard(currencies: ["€", "£", "¥"])
    }
}
