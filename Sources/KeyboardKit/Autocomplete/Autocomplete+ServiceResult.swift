//
//  Autocomplete+ServiceResult.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-13.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type represents the autocomplete service result
    /// that can be returned by an ``AutocompleteService``.
    struct ServiceResult {

        /// Create an autocomplete result for an `inputText`.
        ///
        /// - Parameters:
        ///   - inputText: The originally provided text.
        ///   - suggestions: Resulting autocomplete suggestions.
        ///   - emojiSuggestions: Emoji completion matches, if any.
        ///   - nextCharacterPredictions: Next character predictions, if any.
        ///   - isOutdated: Whether the result is outdated and should be ignored.
        public init(
            inputText: String,
            suggestions: [Suggestion],
            emojiSuggestions: [Suggestion]? = nil,
            nextCharacterPredictions: [Character: Double]? = nil,
            isOutdated: Bool = false
        ) {
            self.inputText = inputText
            self.suggestions = suggestions
            self.emojiSuggestions = emojiSuggestions
            self.nextCharacterPredictions = nextCharacterPredictions
            self.isOutdated = isOutdated
        }

        /// The originally provided text.
        public let inputText: String

        /// Suggestions for the provided texts.
        public let suggestions: [Suggestion]
        
        /// Emoji suggestions, if any.
        public let emojiSuggestions: [Suggestion]?

        /// Next character predictions for the provided text, if any.
        public let nextCharacterPredictions: [Character: Double]?

        /// Whether the result is outdated and should be ignored.
        public let isOutdated: Bool
    }
}
