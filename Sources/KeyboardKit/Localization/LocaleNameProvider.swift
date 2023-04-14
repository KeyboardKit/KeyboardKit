//
//  LocaleNameProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to provide localized names for locales.

 Implementing the protocol will extend the implementing type
 with functions that use public `Locale` extensions with the
 same names. While you can use the protocol, the main reason
 for having it is to expose these extensions to DocC.
 */
public protocol LocaleNameProvider {}

public extension LocaleNameProvider {

    /**
     The full name of a locale in its own language.
     */
    func localizedName(of locale: Locale) -> String? {
        locale.localizedName
    }

    /**
     The full name of a locale in another locale's language.
     */
    func localizedName(of locale: Locale, in other: Locale) -> String? {
        locale.localizedName(in: other)
    }

    /**
     The language name of a locale in its own language.
     */
    func localizedLanguageName(of locale: Locale) -> String? {
        locale.localizedLanguageName
    }

    /**
     The language name of a locale in this locale.
     */
    func localizedLanguageName(of locale: Locale, in other: Locale) -> String? {
        locale.localizedLanguageName(in: other)
    }

    /**
     Sort a collection by localized name then place a locale
     first, if one is provided.

     - Parameters:
       - locales: The locales to sort.
       - insertFirst: The locale to place first, by default `nil`.
     */
    func sort(
        _ locales: [Locale],
        insertFirst first: Locale? = nil
    ) -> [Locale] {
        locales.sorted(insertFirst: first)
    }

    /**
     Sort a collection by the localized name in the `locale`
     then place a locale first, if one is provided.

     - Parameters:
       - locales: The locales to sort.
       - locale: The locale to use to get the localized name.
       - insertFirst: The locale to place first, by default `nil`.
     */
    func sort(
        _ locales: [Locale],
        in locale: Locale,
        insertFirst first: Locale? = nil
    ) -> [Locale] {
        locales.sorted(in: locale, insertFirst: first)
    }
}


// MARK: - Locale

public extension Locale {

    /**
     The full name of this locale in its own words.
     */
    var localizedName: String {
        localizedString(forIdentifier: identifier) ?? ""
    }

    /**
     The full name of this locale in the provided locale.
     */
    func localizedName(in locale: Locale) -> String {
        locale.localizedString(forIdentifier: identifier) ?? ""
    }

    /**
     The language name of this locale in its own words.
     */
    var localizedLanguageName: String {
        localizedString(forLanguageCode: languageCode ?? "") ?? ""
    }

    /**
     The language name of this locale in the provided locale.
     */
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
