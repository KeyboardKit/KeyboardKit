//
//  InputSet+English.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-08-26.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AlphabeticInputSet {

    /**
     A standard, English `qwerty` input set.
     */
    static let english = AlphabeticInputSet(rows: [
        .init("qwertyuiop"),
        .init("asdfghjkl"),
        .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
    ])
}

public extension NumericInputSet {

    /**
     A standard, English input set.
     */
    static func english(currency: String) -> NumericInputSet {
        NumericInputSet(rows: [
            .init("1234567890"),
            .init(phone: "-/:;()\(currency)&@”", pad: "@#\(currency)&*()’”"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
}

public extension SymbolicInputSet {

    /**
     A standard, English input set.
     */
    static func english(currency: String) -> SymbolicInputSet {
        SymbolicInputSet(rows: [
            .init(phone: "[]{}#%^*+=", pad: "1234567890"),
            .init(phone: "_\\|~<>€\(currency)¥•", pad: "€\(currency)¥_^[]{}"),
            .init(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
