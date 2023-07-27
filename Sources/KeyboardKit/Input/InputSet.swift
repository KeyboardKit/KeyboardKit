//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 An input set defines the input keys on a keyboard.
 
 The input keys can then be used to create a keyboard layout,
 which defines the full set of keys of a keyboard, including
 the surrounding action keys.
 
 `v8.0` - This protocol will be converted to a struct, which
 will replace the various input set types with a single type.
 */
public protocol InputSet: Equatable {
    
    var rows: InputSetRows { get }
}

public extension InputSet {
    
    /// A standard, English alphabetic input set.
    static var english: AlphabeticInputSet { .qwerty }
    
    /// A standard, English numeric input set.
    static var englishNumeric: NumericInputSet {
        .englishNumeric()
    }
    
    /// A standard, English numeric input set.
    static func englishNumeric(
        currency: String = "$"
    ) -> NumericInputSet {
        .standardNumeric(currency: currency)
    }
    
    /// A standard, English symbolic input set.
    static var englishSymbolic: SymbolicInputSet {
        .englishSymbolic()
    }
    
    /// A standard, English symbolic input set.
    static func englishSymbolic(
        currency: String = "£"
    ) -> SymbolicInputSet {
        .standardSymbolic(currencies: "€\(currency)¥".chars)
    }
    
    /// A standard `QWERTY` alphabetic input set.
    static var qwerty: AlphabeticInputSet {
        .init(rows: [
            .init(chars: "qwertyuiop"),
            .init(chars: "asdfghjkl"),
            .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    /// A standard numeric input set with a custom currency.
    static func standardNumeric(currency: String) -> NumericInputSet {
        NumericInputSet(rows: [
            .init(chars: "1234567890"),
            .init(phone: "-/:;()\(currency)&@”", pad: "@#\(currency)&*()’”"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
    
    /// A standard symbolic input set with custom currencies.
    static func standardSymbolic(currencies: [String]) -> SymbolicInputSet {
        SymbolicInputSet(rows: [
            .init(phone: "[]{}#%^*+=", pad: "1234567890"),
            .init(
                phone: "_\\|~<>\(currencies.joined())•",
                pad: "\(currencies.joined())_^[]{}"),
            .init(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}

/**
 This input set can be used in alphabetic keyboards.
 
 `v8.0` - This will be replaced by the upcoming `InputSet`.
 */
public struct AlphabeticInputSet: InputSet {

    /**
     Create an alphabetic input set.
     */
    public init(rows: InputSetRows) {
        self.rows = rows
    }

    /**
     The rows in the input set.
     */
    public var rows: InputSetRows
}

/**
 This input set can used in numeric keyboards.
 
 `v8.0` - This will be replaced by the upcoming `InputSet`.
 */
public struct NumericInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}

/**
 This input set can be used in symbolic keyboards.
 
 `v8.0` - This will be replaced by the upcoming `InputSet`.
 */
public struct SymbolicInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}
