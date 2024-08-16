//
//  KeyboardLocaleInfo+Query.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-16.
//

import Foundation

public extension KeyboardLocaleInfo {

    /// Whether the locale matches a query in a locale.
    func matches(
        query: String,
        in locale: Locale = .current
    ) -> Bool {
        let query = query.trimmingCharacters(in: .whitespaces)
        if query.isEmpty { return true }
        return localizedName.matches(query) || localizedName(in: locale).matches(query)
    }

    /// Whether the locale matches a query in a locale.
    func matches(
        query: String,
        in locale: KeyboardLocale
    ) -> Bool {
        matches(query: query, in: locale.locale)
    }
}

private extension String {

    func matches(_ query: String) -> Bool {
        self.lowercased().contains(query.lowercased())
    }
}
