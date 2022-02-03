//
//  InputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to provide ``InputSet`` values for keyboard layouts.
 
 An ``InputSet`` defines the input keys on a system keyboard.
 The keys can then be used to create a layout, which defines
 the full set of keys, including the surrounding system keys.
 */
public protocol InputSetProvider: AnyObject {
    
    /**
     The input set to use for alphabetic keyboards.
     */
    var alphabeticInputSet: AlphabeticInputSet { get }

    /**
     The input set to use for numeric keyboards.
     */
    var numericInputSet: NumericInputSet { get }

    /**
     The input set to use for symbolic keyboards.
     */
    var symbolicInputSet: SymbolicInputSet { get }
}

public extension InputSetProvider {
    
    /**
     Create an input row from a string.
     */
    func row(_ chars: String) -> InputSetRow {
        InputSetRow(chars.chars)
    }
    
    /**
     Create an input row from a char array.
     */
    func row(_ chars: [String]) -> InputSetRow {
        InputSetRow(chars)
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     string array, which are mapped to `InputSetItem` arrays.
     
     Both arrays must contain the same amount of characters.
     */
    func row(
        lowercased: [String],
        uppercased: [String]) -> InputSetRow {
        InputSetRow(
            lowercased: lowercased,
            uppercased: uppercased)
    }
}
