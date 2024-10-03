//
//  Emoji+Search.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {

    /// Whether or not the emoji matches a certain query.
    func matches(
        _ query: String,
        for locale: Locale = .current
    ) -> Bool {
        let query = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        if query.isEmpty { return true }
        if unicodeName.matches(query) { return true }
        return localizedName(for: locale).matches(query)
    }
}

public extension Collection where Element == Emoji {

    // Find all emojis that match a certain search query.
    func matching(
        _ query: String,
        for locale: Locale = .current
    ) -> [Emoji] {
        filter { $0.matches(query, for: locale) }
    }
}

private extension String {
    
    func matches(_ query: String) -> Bool {
        query
            .split(separator: " ")
            .allSatisfy { localizedStandardContains($0) }
    }
}
