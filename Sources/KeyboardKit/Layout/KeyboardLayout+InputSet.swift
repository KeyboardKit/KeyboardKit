//
//  KeyboardLayout+InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout {

    /// A keyboard layout input set defines which input keys
    /// to add to a keyboard layout.
    ///
    /// While a keyboard layout can be identical for several
    /// locales and keyboard types, the input set can change.
    ///
    /// KeyboardKit defines basic input sets like ``qwerty``,
    /// ``numeric(currency:)`` and ``symbolic(currencies:)``,
    /// while KeyboardKit Pro unlocks extra input sets, like
    /// `qwertz`, `azerty`, `colemak`, and `dvorak`, as well
    /// as locale-specific ones for all supported locales.
    struct InputSet: KeyboardModel {

        /// Create an input set with rows.
        public init(
            rows: ItemRows
        ) {
            self.rows = rows
        }

        /// The rows in the input set.
        public var rows: ItemRows
    }
}

public extension KeyboardLayout.InputSet {

    func characters(
        for case: Keyboard.KeyboardCase,
        device: DeviceType
    ) -> [[String]] {
        rows.map {
            $0.characters(for: `case`, device: device)
        }
    }

    func characterStrings(
        for case: Keyboard.KeyboardCase,
        device: DeviceType
    ) -> [String] {
        characters(for: `case`, device: device)
            .map { $0.joined() }
    }
}

public extension KeyboardLayout.InputSet {

    /// A standard QWERTY input set.
    static var qwerty: Self {
        .init(rows: [
            .init(chars: "qwertyuiop"),
            .init(chars: "asdfghjkl"),
            .init(chars: "zxcvbnm", deviceVariations: [.pad: "zxcvbnm,."])
        ])
    }

    /// A standard numeric input set.
    static var numeric: Self {
        numeric(currency: "$")
    }

    /// A standard numeric input set.
    ///
    /// - Parameters:
    ///   - currency: The currency input to add, by default `$`.
    static func numeric(
        currency: String
    ) -> Self {
        .init(rows: [
            .init(chars: "1234567890"),
            .init(
                chars: "-/:;()\(currency)&@”",
                deviceVariations: [.pad: "@#\(currency)&*()’”"]
            ),
            .init(chars: ".,?!’", deviceVariations: [.pad: "%-+=/;:!?"])
        ])
    }

    /// A standard symbolic input set.
    static var symbolic: Self {
        symbolic(currencies: "€£¥".chars)
    }

    /// A standard symbolic input set.
    ///
    /// - Parameters:
    ///   - currencies: The currency inputs to add.
    static func symbolic(
        currencies: [String]
    ) -> Self {
        .init(rows: [
            .init(chars: "[]{}#%^*+=", deviceVariations: [.pad: "1234567890"]),
            .init(
                chars: "_\\|~<>\(currencies.joined())•",
                deviceVariations: [.pad: "\(currencies.joined())_^[]{}"]
            ),
            .init(chars: ".,?!’", deviceVariations: [.pad: "§|~…\\<>!?"])
        ])
    }

    /// A standard symbolic input set.
    ///
    /// - Parameters:
    ///   - currencies: The currency inputs to add.
    static func symbolic(
        currencies: String
    ) -> Self {
        .symbolic(currencies: currencies.chars)
    }
}
