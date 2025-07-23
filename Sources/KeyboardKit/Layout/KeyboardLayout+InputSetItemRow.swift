//
//  KeyboardLayout+InputSetItemRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayout.InputSet {

    /// This type represents an input set item row.
    ///
    /// There are many convenience initializers to assist us
    /// in creating input set rows in different ways.
    struct ItemRow: KeyboardModel {

        /// Create an input set row.
        ///
        /// - Parameters:
        ///   - items: The base row items.
        ///   - deviceVariations: Device-specific item variations, if any.
        public init(
            items: [Item],
            deviceVariations: [DeviceType: [Item]] = [:]
        ) {
            self.items = items
            self.deviceVariations = deviceVariations
        }

        /// The base row items.
        public let items: [Item]

        /// Device-specific item variations, if any.
        public let deviceVariations: [DeviceType: [Item]]

        /// This typealias represents a row device variation.
        public typealias DeviceVariations = [DeviceType: [Item]]
    }

    /// This typealias represents a list of input set rows.
    typealias ItemRows = [ItemRow]
}

public extension KeyboardLayout.InputSet.ItemRow {

    /// An internal typealias for cleaner code.
    typealias Item = KeyboardLayout.InputSet.Item

    /// Get all input items for a certain device.
    func items(
        for device: DeviceType
    ) -> [Item] {
        deviceVariations[device] ?? items
    }

    /// Get all input characters for a certain keyboard case.
    func characters(
        for case: Keyboard.KeyboardCase,
        device: DeviceType
    ) -> [String] {
        items(for: device).map { $0.character(for: `case`) }
    }
}

public extension KeyboardLayout.InputSet.ItemRows {

    /// Get all input characters for a certain keyboard case.
    func characters(
        for case: Keyboard.KeyboardCase,
        device: DeviceType
    ) -> [[String]] {
        map { $0.characters(
            for: `case`,
            device: device
        )}
    }
}

// MARK: - Convenience Initializers

public extension KeyboardLayout.InputSet.ItemRow {

    /// Create an input row from a character string.
    ///
    /// This is convenient to use when you can pass separate
    /// characters as a single string, that will be split up.
    init(chars: String) {
        self.init(chars: chars, deviceVariations: [:])
    }

    /// Create an input row from a character string.
    ///
    /// This is convenient to use when you can pass separate
    /// characters as a single string, that will be split up.
    init(
        chars: String,
        deviceVariations: [DeviceType: String] = [:]
    ) {
        self.init(
            chars: chars.chars,
            deviceVariations: deviceVariations.mapValues({ chars in
                chars.chars
            })
        )
    }

    /// Create an input row from a character array.
    ///
    /// This is convenient to use when any row item must use
    /// two chars in its string, like the Swedish `kr`.
    init(chars: [String]) {
        self.init(chars: chars, deviceVariations: [:])
    }

    /// Create an input row from a character array.
    ///
    /// This is convenient to use when any row item must use
    /// two chars in its string, like the Swedish `kr`.
    init(
        chars: [String],
        deviceVariations: [DeviceType: [String]] = [:]
    ) {
        self.init(
            items: chars.map { Item($0) },
            deviceVariations: deviceVariations.mapValues({ chars in
                chars.map { Item($0) }
            })
        )
    }

    /// Create an input row from two cased character strings.
    init(lowercased: String, uppercased: String) {
        self.init(
            lowercased: lowercased.chars,
            uppercased: uppercased.chars
        )
    }

    /// Create an input row from two cased character strings.
    init(
        lowercased: String, uppercased: String,
        deviceVariations: [DeviceType: (lowercased: String, uppercased: String)] = [:]
    ) {
        self.init(
            lowercased: lowercased.chars,
            uppercased: uppercased.chars,
            deviceVariations: deviceVariations.mapValues({ lowercased, uppercased in
                (lowercased.chars, uppercased.chars)
            })
        )
    }

    /// Create an input row from cased character arrays.
    init(lowercased: [String], uppercased: [String]) {
        self.init(lowercased: lowercased, uppercased: uppercased, deviceVariations: [:])
    }

    /// Create an input row from cased character arrays.
    init(
        lowercased: [String], uppercased: [String],
        deviceVariations: [DeviceType: (lowercased: [String], uppercased: [String])] = [:]
    ) {
        let equal = lowercased.count == uppercased.count
        assert(equal, "lowercased and uppercased must contain the same number of characters")
        self.init(
            items: lowercased.indices.map {
                Item(
                    neutral: lowercased[$0],
                    uppercased: uppercased[$0],
                    lowercased: lowercased[$0]
                )
            },
            deviceVariations: deviceVariations.mapValues({ lowercased, uppercased in
                lowercased.indices.map {
                    Item(
                        neutral: lowercased[$0],
                        uppercased: uppercased[$0],
                        lowercased: lowercased[$0]
                    )
                }
            })
        )
    }
}
