//
//  KeyboardInputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A keyboard input set represents the input parts of a system
 keyboard, the center lighter input keys.
 */
public class KeyboardInputSet: Equatable {
    
    public init(rows: KeyboardInputRows) {
        self.rows = rows
    }
    
    public let rows: KeyboardInputRows
    
    public static func == (lhs: KeyboardInputSet, rhs: KeyboardInputSet) -> Bool {
        lhs.rows == rhs.rows
    }
}

/**
 This input set can be used in alphabetic keyboards.
 */
public class AlphabeticKeyboardInputSet: KeyboardInputSet {}

/**
 This input set can used in numeric keyboards.
 */
public class NumericKeyboardInputSet: KeyboardInputSet {}

/**
 This input set can be used in symbolic keyboards.
 */
public class SymbolicKeyboardInputSet: KeyboardInputSet {}
