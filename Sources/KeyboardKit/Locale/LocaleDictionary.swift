//
//  LocaleDictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This dictionary can store items in a way that makes it easy
 to resolve them for a certain locale.
 
 When resolving items for locales, the dictionary will first
 try to find a value for the locale's `identifier`, then the
 locale's `languageCode`.
 */
public struct LocaleDictionary<ItemType> {
    
    public init(_ dict: [KeyboardLocale: ItemType]) {
        self.dictionary = Dictionary(
            uniqueKeysWithValues: dict.keys.compactMap {
                guard let value = dict[$0] else { return nil }
                return ($0.localeIdentifier, value)
            }
        )
    }
    
    public init(_ dict: [String: ItemType]) {
        self.dictionary = dict
    }
    
    public let dictionary: [String: ItemType]
    
    public func value(for locale: Locale) -> ItemType? {
        if let item = dictionary[locale.identifier] { return item }
        if let item = dictionary[locale.languageCode ?? ""] { return item }
        return nil
    }
}
