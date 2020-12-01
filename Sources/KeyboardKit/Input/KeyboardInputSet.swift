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
 
 Note that iPad may add additional inputs like punctionation
 and special characters. These inputs are considered to be a
 part of the keyboard layout, not the input set.
 */
public class KeyboardInputSet: Equatable {
    
    public init(inputRows: [InputRow]) {
        self.inputRows = inputRows
    }
    
    public typealias InputRow = [String]
    
    public let inputRows: [InputRow]
    
    public static func == (lhs: KeyboardInputSet, rhs: KeyboardInputSet) -> Bool {
        lhs.inputRows == rhs.inputRows
    }
}

/**
 This input set should only be used in alphabetic keyboards.
 */
public class AlphabeticKeyboardInputSet: KeyboardInputSet {}

/**
 This input set should only be used in numeric keyboards.
 */
public class NumericKeyboardInputSet: KeyboardInputSet {}

/**
 This input set should only be used in symbolic keyboards.
 */
public class SymbolicKeyboardInputSet: KeyboardInputSet {}
