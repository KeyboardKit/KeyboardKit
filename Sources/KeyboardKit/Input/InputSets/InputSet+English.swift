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
     A standard, English `QWERTY` input set.
     */
    static let english = AlphabeticInputSet(rows: [
        .init("qwertyuiop"),
        .init("asdfghjkl"),
        .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
    ])

    /**
     An English `AZERTY` input set.
     */
    static let englishAzerty = AlphabeticInputSet(rows: [
        .init("azertyuiop"),
        .init("qsdfghjklm"),
        .init(phone: "wxcvbn", pad: "zxcvbnm,.‘")
    ])

    /**
     An English `QWERTY` input set.
     */
    static let englishQwerty = AlphabeticInputSet.english

    /**
     An English `QWERTZ` input set.
     */
    static let englishQwertz = AlphabeticInputSet(rows: [
        .init("qwertzuiop"),
        .init("asdfghjkl"),
        .init(phone: "yxcvbnm", pad: "yxcvbnm,")
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
