//
//  Autocomplete+Suggestion.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type represents an autocomplete suggestion that
    /// is returned by an ``AutocompleteService``.
    ///
    /// Suggestions can either be standard ones that require
    /// users to manually apply them, or autocorrecting ones
    /// that are auto-applied when a word delimiter is typed.
    ///
    /// Native keyboards typically present an autocorrecting
    /// suggestion with a semi-white background, and unknown
    /// or current words with locale-specific quotation.
    struct Suggestion: Codable, Equatable, Hashable {

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
            additionalInfo: [String: String] = [:]
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
        public var additionalInfo: [String: String]
    }
}

public extension Autocomplete.Suggestion {

    /// Whether the suggestion is an autocorrect suggestion.
    var isAutocorrect: Bool {
        type == .autocorrect
    }

    /// Whether the suggestion is a regular suggestion.
    var isRegular: Bool {
        type == .regular
    }

    /// Whether the suggestion is an unknown suggestion.
    var isUnknown: Bool {
        type == .unknown
    }

    /// Adjust the ``text`` casing to match a certain word.
    func autocompleteCased(
        for word: String
    ) -> Autocomplete.Suggestion {
        var result = self
        result.text = result.text.autocompleteCased(for: word)
        return result
    }
}

public extension Autocomplete {

    /// This enum defines every autocomplete suggestion type
    /// that can be returned by an ``AutocompleteService``.
    enum SuggestionType: String, CaseIterable, Codable, Equatable {

        /// These suggestions are only applied when the user
        /// taps them.
        ///
        /// Native keyboards display all regular suggestions
        /// as plain text, but you can customize this.
        case regular

        /// These suggestions are automatically applied when
        /// the user taps a word or sentence delimiter.
        ///
        /// Native keyboards display autocorrect suggestions
        /// with a rounded white background.
        case autocorrect

        /// These suggestions can be used when the currently
        /// typed word is unknown, to automatically learn it.
        ///
        /// Native keyboards display unknown suggestions and
        /// the current word although known, with quotes.
        case unknown
    }
}

private extension String {

    func autocompleteCased(for word: String) -> String {
        let isUppercased = word.count > 1 && word == word.uppercased()
        return isUppercased ? uppercased() : self
    }
}

public extension Collection where Element == Autocomplete.Suggestion {

    /// Check if the collection contains a suggestion with a
    /// certain `word`.
    func contains(_ word: String) -> Bool {
        contains { $0.text.caseInsensitiveCompare(word) == .orderedSame }
    }

    /// Adjust the collection to either keep or remove items
    /// that are autocorrecting.
    func withAutocorrectEnabled(
        _ isEnabled: Bool
    ) -> [Element] {
        map {
            if isEnabled { return $0 }
            guard $0.type == .autocorrect else { return $0 }
            var element = $0
            element.type = .regular
            return element
        }
    }
}
