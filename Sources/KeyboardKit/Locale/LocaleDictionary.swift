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
    
    public init(_ dict: [String: ItemType]) {
        self.dict = dict
    }
    
    private let dict: [String: ItemType]
    
    func value(for locale: Locale) -> ItemType? {
        if let item = dict[locale.identifier] { return item }
        if let item = dict[locale.languageCode ?? ""] { return item }
        return nil
    }
}
