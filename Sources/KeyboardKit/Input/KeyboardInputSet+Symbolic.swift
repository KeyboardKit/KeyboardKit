//
//  KeyboardInputSet+Symbolic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This file contains various symbolic input sets.
 */
public extension KeyboardInputSet {
    
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

public extension KeyboardInputSet {
    
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
