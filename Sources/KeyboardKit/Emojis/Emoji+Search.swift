//
//  Emoji+Search.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {

    /**
     Whether or not the emoji matches a certain search query
     for the provided locale.

     You can also use `matching(_:for:)` on a collection, to
     find all emojis in the collection that matches a query.
     */
    func matches(_ query: String, for locale: KeyboardLocale) -> Bool {
        matches(query, for: locale.locale)
    }

    /**
     Whether or not the emoji matches a certain search query
     for the provided locale.

     You can also use `matching(_:for:)` on a collection, to
     find all emojis in the collection that matches a query.
     */
    func matches(_ query: String, for locale: Locale) -> Bool {
        let query = query.trimming(.whitespacesAndNewlines).lowercased()
        if query.isEmpty { return true }
        if unicodeName?.lowercased().contains(query) == true { return true }
        if localizedName(for: locale).lowercased().contains(query) { return true }
        return false
    }
}

public extension Collection where Element == Emoji {

    /**
     Find all emojis that match a certain search query for a
     certain locale.
     */
    func matching(_ query: String, for locale: KeyboardLocale) -> [Emoji] {
        matching(query, for: locale.locale)
    }

    /**
     Find all emojis that match a certain search query for a
     certain locale.
     */
    func matching(_ query: String, for locale: Locale) -> [Emoji] {
        filter { $0.matches(query, for: locale) }
    }
}
