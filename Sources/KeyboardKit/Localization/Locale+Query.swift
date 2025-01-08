//
//  Locale+Query.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-16.
//

import Foundation

public extension Locale {

    /// Whether the locale matches a query in a locale.
    func matches(
        query: String,
        in locale: Locale = .current
    ) -> Bool {
        let query = query.trimmingCharacters(in: .whitespaces)
        if query.isEmpty { return true }
        let name = localizedName ?? ""
        let nameInLocale = localizedName(in: locale) ?? ""
        return name.contains(query) || nameInLocale.contains(query)
    }
}

public extension Collection where Element == Locale {

    /// Filter out all locales that matches a certain query.
    func matching(
        query: String,
        in locale: Locale = .current
    ) -> [Locale] {
        filter { $0.matches(query: query, in: locale) }
    }
}

private extension String {

    func contains(_ query: String) -> Bool {
        localizedCaseInsensitiveContains(query)
    }
}
