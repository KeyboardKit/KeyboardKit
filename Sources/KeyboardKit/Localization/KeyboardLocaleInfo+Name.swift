//
//  KeyboardLocaleInfo+Name.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLocaleInfo {

    /// The full name of this locale in its own language.
    var localizedName: String {
        localizedName(in: locale)
    }

    /// The full name of this locale in another locale.
    func localizedName(in locale: KeyboardLocale) -> String {
        localizedName(in: locale.locale)
    }

    /// The full name of this locale in another locale.
    func localizedName(in locale: Locale) -> String {
        if self.locale.identifier == "ckb_PC" {
            let sorani = KeyboardLocale.kurdish_sorani.locale
            return sorani.localizedName(in: locale) + " (PC)"
        }
        return locale.localizedString(forIdentifier: self.locale.identifier) ?? ""
    }

    /// The language name of this locale in its own language.
    var localizedLanguageName: String {
        localizedLanguageName(in: locale)
    }

    /// The language name of this locale in another locale.
    func localizedLanguageName(in locale: KeyboardLocale) -> String {
        localizedLanguageName(in: locale.locale)
    }

    /// The language name of this locale in another locale.
    func localizedLanguageName(in locale: Locale) -> String {
        locale.localizedString(forLanguageCode: self.locale.languageCode ?? "") ?? ""
    }
}

public extension Collection where Element: KeyboardLocaleInfo {

    /// Sort the collection by the localized item name, then
    /// optionally place a locale first.
    ///
    /// - Parameters:
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.localizedName.lowercased() < $1.localizedName.lowercased() },
            insertFirst: first
        )
    }

    /// Sort the collection by the localized item name for a
    /// certain locale, then optionally place a locale first.
    ///
    /// - Parameters:
    ///   - locale: The locale to use to get the localized name.
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        in locale: Locale,
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.localizedName(in: locale).lowercased() < $1.localizedName(in: locale).lowercased() },
            insertFirst: first
        )
    }

    /// Sort the collection by a sort comparator, then place
    /// a locale first in the sorted result.
    ///
    /// - Parameters:
    ///   - comparator: The sort comparator to use.
    ///   - first: The locale to place first, by default `nil`.
    func sorted(
        by comparator: (Element, Element) -> Bool,
        insertFirst first: Element?
    ) -> [Element] {
        let sorted = self.sorted(by: comparator)
        guard let first = first else { return sorted }
        var filtered = sorted.filter { $0.locale.identifier != first.locale.identifier }
        filtered.insert(first, at: 0)
        return filtered
    }
}
