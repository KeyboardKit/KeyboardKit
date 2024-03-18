//
//  LocaleDictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This dictionary can store items in a way that makes it easy
 to resolve them for a certain locale.
 
 When resolving items, the dictionary will first try to find
 a value for the locale `identifier`, then the `languageCode`.
 */
public struct LocaleDictionary<ItemType> {
    
    /// Create a dictionary with locale entries.
    public init(_ dict: [KeyboardLocale: ItemType]) {
        self.dictionary = Dictionary(
            uniqueKeysWithValues: dict.keys.compactMap {
                guard let value = dict[$0] else { return nil }
                return ($0.localeIdentifier, value)
            }
        )
    }
    
    /// Create a dictionary with locale entries.
    public init(_ dict: [LocaleIdentifier: ItemType]) {
        self.dictionary = dict
    }
    
    /// This alias indicates the dictionary key type.
    public typealias LocaleIdentifier = String
    
    /// The locale/valye dicitionary.
    public var dictionary: [LocaleIdentifier: ItemType]
}

public extension LocaleDictionary {
    
    /// Get a certain value for the provided locale.
    func value(for locale: Locale) -> ItemType? {
        if let item = dictionary[locale.identifier] { return item }
        if let item = dictionary[locale.languageCode ?? ""] { return item }
        return nil
    }
    
    /// Insert a value into the dictionary.
    mutating func set(_ value: ItemType, for locale: Locale) {
        set(value, for: locale.identifier)
    }
    
    /// Insert a value into the dictionary.
    mutating func set(_ value: ItemType, for localeIdentifier: String) {
        dictionary[localeIdentifier] = value
    }
}

public extension LocaleDictionary {
    
    /// Get a certain value for the provided locale.
    func value(for locale: KeyboardLocale) -> ItemType? {
        value(for: locale.locale)
    }
    
    /// Insert a value into the dictionary.
    mutating func set(_ value: ItemType, for locale: KeyboardLocale) {
        set(value, for: locale.locale)
    }
}
