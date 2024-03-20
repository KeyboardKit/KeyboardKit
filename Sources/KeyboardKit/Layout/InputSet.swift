//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// An input set defines the input keys on a keyboard.
///
/// Input sets are used to create ``KeyboardLayout``s, which
/// define the full set of keys of a keyboard, including the
/// keys surrounding the input rows and a bottom row.
///
/// KeyboardKit has pre-defined input sets, such as ``qwerty``,
/// ``numeric(currency:)`` and ``symbolic(currencies:)``, to
/// let you easily get started with a base setup that can be
/// tweaked as needed.
///
/// KeyboardKit Pro unlocks additional input sets to support
/// more locales, like `qwertz` and `azerty`.
public struct InputSet: Equatable {
    
    /// Create an input set with rows.
    public init(rows: Rows) {
        self.rows = rows
    }

    /// The rows in the input set.
    public var rows: Rows
}

public extension InputSet {
    
    static var qwerty: InputSet {
        .init(rows: [
            .init(chars: "qwertyuiop"),
            .init(chars: "asdfghjkl"),
            .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    static func numeric(currency: String) -> InputSet {
        .init(rows: [
            .init(chars: "1234567890"),
            .init(phone: "-/:;()\(currency)&@”", pad: "@#\(currency)&*()’”"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
    
    static func symbolic(currencies: [String]) -> InputSet {
        .init(rows: [
            .init(phone: "[]{}#%^*+=", pad: "1234567890"),
            .init(
                phone: "_\\|~<>\(currencies.joined())•",
                pad: "\(currencies.joined())_^[]{}"),
            .init(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}
