//
//  Autocomplete+Suggestion.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type represents an autocomplete suggestion that
    /// is returned by an ``AutocompleteService``.
    ///
    /// Autocomplete suggestions can be standard suggestions
    /// or autocorrecting suggestions that are automatically
    /// applied when a word delimiter is applied.
    ///
    /// Native keyboards typically present an autocorrecting
    /// suggestion with a semi-white background, and unknown
    /// or current words with locale-specific quotation, but
    /// you can customize this as you see fit.
    struct Suggestion {

        /// Create an autocomplete suggestion.
        ///
        /// - Parameters:
        ///   - text: The text that should be sent to the proxy.
        ///   - type: The type of suggestion this is, by default `.regular`.
        ///   - title: The text that should be displayed, by default `text`.
        ///   - subtitle: An optional subtitle that can complete the title, by default `nil`.
        ///   - source: An optional source to describe where the suggestion is from, by default `nil`.
        ///   - additionalInfo: An optional info dictionary, by default `empty`.
        public init(
            text: String,
            type: SuggestionType = .regular,
            title: String? = nil,
            subtitle: String? = nil,
            source: String? = nil,
            additionalInfo: [String: Any] = [:]
        ) {
            self.text = text
            self.type = type
            self.title = title ?? text
            self.subtitle = subtitle
            self.source = source
            self.additionalInfo = additionalInfo
        }

        /// The text that should be sent to the proxy.
        public var text: String

        /// The type of suggestion this is.
        public var type: SuggestionType

        /// The text that should be displayed.
        public var title: String

        /// An optional subtitle that can complete the title.
        public var subtitle: String?

        /// An optional source to describe where the suggestion is from.
        public var source: String?

        /// An optional info dictionary.
        public var additionalInfo: [String: Any]
    }
}

public extension Autocomplete.Suggestion {

    /// Whether the suggestion is autocorrecting.
    var isAutocorrect: Bool {
        type == .autocorrect
    }

    /// Whether the suggestion is unknown.
    var isUnknown: Bool {
        type == .unknown
    }

    /// Adjust the ``text`` casing to match a certain word.
    func withAutocompleteCasing(
        for word: String
    ) -> Autocomplete.Suggestion {
        var result = self
        result.text = result.text.withAutocompleteCasing(for: word)
        return result
    }
}

private extension String {

    func withAutocompleteCasing(for word: String) -> String {
        let isUppercased = word.count > 1 && word == word.uppercased()
        return isUppercased ? uppercased() : self
    }
}

public extension Collection where Element == Autocomplete.Suggestion {

    func contains(_ word: String) -> Bool {
        contains { $0.text.caseInsensitiveCompare(word) == .orderedSame }
    }
}
