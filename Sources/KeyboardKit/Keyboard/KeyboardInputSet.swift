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
 and special characters. This should be handled by a service
 that takes device, locale & orientation into consideration.
 */
public class KeyboardInputSet {
    
    public init(inputRows: [[String]]) {
        self.inputRows = inputRows
    }
    
    public let inputRows: [[String]]
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
