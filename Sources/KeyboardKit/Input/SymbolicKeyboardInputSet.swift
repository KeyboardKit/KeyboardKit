//
//  SymbolicKeyboardInputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set can be used in symbolic keyboards.
 */
public class SymbolicKeyboardInputSet: KeyboardInputSet {}

public extension SymbolicKeyboardInputSet {
    
    static func standard(currencies: [String]) -> SymbolicKeyboardInputSet {
        SymbolicKeyboardInputSet(inputRows: [
            standardTopRow,
            standardCenterRow(currencies: currencies),
            standardBottomRow
        ])
    }
    
    static var standardTopRow: [String] {
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="]
    }
    
    static func standardCenterRow(currencies: [String]) -> [String] {
        ["_", "\\", "|", "~", "<", ">"] + currencies + ["•"]
    }
    
    static var standardBottomRow: [String] {
        NumericKeyboardInputSet.standardBottomRow
    }
}
