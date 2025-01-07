//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
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
/// help you get started. KeyboardKit Pro unlocks additional
/// input sets, like `qwertz` & `azerty` and locale-specific
/// input sets for each supported locale.
///
/// See <doc:Layout-Article> for more information.
public struct InputSet: Equatable {
    
    /// Create an input set with rows.
    public init(
        rows: ItemRows
    ) {
        self.rows = rows
    }

    /// The rows in the input set.
    public var rows: ItemRows
}

public extension InputSet {

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

public extension InputSet {

    /// A standard QWERTY input set.
    static var qwerty: InputSet {
        .init(rows: [
            .init(chars: "qwertyuiop"),
            .init(chars: "asdfghjkl"),
            .init(chars: "zxcvbnm", deviceVariations: [.pad: "zxcvbnm,."])
        ])
    }

    /// A standard numeric input set.
    static func numeric(
        currency: String
    ) -> InputSet {
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
    static func symbolic(currencies: [String]) -> InputSet {
        .init(rows: [
            .init(chars: "[]{}#%^*+=", deviceVariations: [.pad: "1234567890"]),
            .init(
                chars: "_\\|~<>\(currencies.joined())•",
                deviceVariations: [.pad: "\(currencies.joined())_^[]{}"]
            ),
            .init(chars: ".,?!’", deviceVariations: [.pad: "§|~…\\<>!?"])
        ])
    }
}
