//
//  Locale+Name.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /// The full name of this locale in its own language.
    var localizedName: String {
        localizedString(forIdentifier: identifier) ?? ""
    }

    /// The full name of this locale in another locale.
    func localizedName(in locale: Locale) -> String {
        locale.localizedString(forIdentifier: identifier) ?? ""
    }

    /// The language name of this locale in its own language.
    var localizedLanguageName: String {
        localizedString(forLanguageCode: languageCode ?? "") ?? ""
    }

    /// The language name of this locale in another locale.
    func localizedLanguageName(in locale: Locale) -> String {
        locale.localizedString(forLanguageCode: languageCode ?? "") ?? ""
    }
}

public extension Collection where Element == Locale {

    /**
     Sort the collection by the localized name of every item
     then optionally place a locale first in the result.

     - Parameters:
       - insertFirst: The locale to place first, by default `nil`.
     */
    func sorted(
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.localizedName.lowercased() < $1.localizedName.lowercased() },
            insertFirst: first
        )
    }

    /**
     Sort the collection by the localized name of every item
     in the provided `locale` then optionally place a locale
     first in the result.

     - Parameters:
       - locale: The locale to use to get the localized name.
       - insertFirst: The locale to place first, by default `nil`.
     */
    func sorted(
        in locale: Locale,
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.localizedName(in: locale).lowercased() < $1.localizedName(in: locale).lowercased() },
            insertFirst: first
        )
    }

    /**
     Sort the collection by the provided sort comparator and
     then optionally place a locale first in the result.

     - Parameters:
       - comparator: The sort comparator to use.
       - insertFirst: The locale to place first, by default `nil`.
     */
    func sorted(
        by comparator: (Locale, Locale) -> Bool,
        insertFirst first: Element?
    ) -> [Element] {
        let sorted = self.sorted(by: comparator)
        guard let first = first else { return sorted }
        var filtered = sorted.filter { $0 != first }
        filtered.insert(first, at: 0)
        return filtered
    }
}
