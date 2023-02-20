//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 An input set defines the input keys on a keyboard. The keys
 can then be used to create a keyboard layout, which defines
 the full set of keys, including the surrounding system keys.
 
 The most flexible way to generate an input set is to use an
 ``InputSetProvider``.
 */
public protocol InputSet: Equatable {
    
    var rows: InputSetRows { get }
}

/**
 This input set can be used in alphabetic keyboards.
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

public extension AlphabeticInputSet {

    /**
     A standard `QWERTY` input set.
     */
    static let qwerty = AlphabeticInputSet(rows: [
        .init(chars: "qwertyuiop"),
        .init(chars: "asdfghjkl"),
        .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
    ])
}

/**
 This input set can used in numeric keyboards.
 */
public struct NumericInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}

public extension NumericInputSet {

    /**
     A standard, numeric input set, used by e.g. the English
     numeric input sets.
     */
    static func standard(currency: String) -> NumericInputSet {
        NumericInputSet(rows: [
            .init(chars: "1234567890"),
            .init(phone: "-/:;()\(currency)&@”", pad: "@#\(currency)&*()’”"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
}

/**
 This input set can be used in symbolic keyboards.
 */
public struct SymbolicInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}

public extension SymbolicInputSet {

    /**
     A standard symbolic input set, used by e.g. the English
     symbolic input sets.
     */
    static func standard(currencies: [String]) -> SymbolicInputSet {
        SymbolicInputSet(rows: [
            .init(phone: "[]{}#%^*+=", pad: "1234567890"),
            .init(
                phone: "_\\|~<>\(currencies.joined())•",
                pad: "\(currencies.joined())_^[]{}"),
            .init(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
