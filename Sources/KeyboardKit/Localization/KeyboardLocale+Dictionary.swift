//
//  KeyboardLocale+Dictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLocale {
    
    /// This locale-based dictionary can store item types to
    /// let you resolve them based on locale.
    ///
    /// When resolving items, this dictionary will first try
    /// to find value for the locale's `identifier` then the
    /// locale's `languageCode`.
    struct Dictionary<ItemType> {

        /// Create a dictionary with locale entries.
        public init(_ dict: [KeyboardLocale: ItemType]) {
            self.dictionary = .init(
                uniqueKeysWithValues: dict.keys.compactMap {
                    guard let value = dict[$0] else { return nil }
                    return ($0.localeIdentifier, value)
                }
            )
        }

        /// Create a dictionary with locale entries.
        public init(_ dict: [Locale: ItemType]) {
            self.dictionary = .init(
                uniqueKeysWithValues: dict.keys.compactMap {
                    guard let value = dict[$0] else { return nil }
                    return ($0.identifier, value)
                }
            )
        }

        /// Create a dictionary with locale entries.
        public init(_ dict: [LocaleIdentifier: ItemType] = [:]) {
            self.dictionary = dict
        }
        
        /// This alias indicates the dictionary key type.
        public typealias LocaleIdentifier = String
        
        /// The locale/valye dicitionary.
        public var dictionary: [LocaleIdentifier: ItemType]
    }
}

public extension KeyboardLocale.Dictionary {

    /// Check if the dictionary has a certain locale value.
    func hasValue(for locale: KeyboardLocaleInfo) -> Bool {
        value(for: locale) != nil
    }

    /// Insert a value into the dictionary.
    mutating func set(_ value: ItemType, for locale: KeyboardLocaleInfo) {
        set(value, for: locale.localeIdentifier)
    }
    
    /// Insert a value into the dictionary.
    mutating func set(_ value: ItemType, for localeIdentifier: String) {
        dictionary[localeIdentifier] = value
    }

    /// Get a certain value for the provided locale.
    func value(for locale: KeyboardLocaleInfo) -> ItemType? {
        if let item = dictionary[locale.localeIdentifier] { return item }
        if let item = dictionary[locale.localeLanguageCode] { return item }
        return nil
    }
}
