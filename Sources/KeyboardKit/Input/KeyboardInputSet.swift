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
 
 Some devices add additional inputs to system keyboards. For
 instance, iPad devices adds punctionation and characters to
 the bottom rows. These inputs are not considered to be part
 of the input set, but rater the keyboard layout.
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
