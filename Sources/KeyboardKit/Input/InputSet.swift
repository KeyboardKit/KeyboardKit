//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 An input set defines the input keys on a keyboard. The keys
 can then be used to create a layout, which defines the full
 set of keys, including the surrounding system keys.
 */
public class InputSet: Equatable {
    
    public init(rows: InputSetRows) {
        self.rows = rows
    }
    
    public let rows: InputSetRows
    
    public static func == (lhs: InputSet, rhs: InputSet) -> Bool {
        lhs.rows == rhs.rows
    }
}

/**
 This input set can be used in alphabetic keyboards.
 */
public class AlphabeticInputSet: InputSet {}

/**
 This input set can used in numeric keyboards.
 */
public class NumericInputSet: InputSet {}

/**
 This input set can be used in symbolic keyboards.
 */
public class SymbolicInputSet: InputSet {}
