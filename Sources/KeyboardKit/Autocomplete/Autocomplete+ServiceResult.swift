//
//  Autocomplete+ServiceResult.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-13.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type represents the autocomplete service result
    /// that is returned by an ``AutocompleteService``.
    ///
    /// Note that various service implementations may return
    /// various results, based on the service's capabilities.
    struct ServiceResult {

        /// Create an autocomplete suggestion.
        ///
        /// - Parameters:
        ///   - inputText: The originally provided text.
        ///   - suggestions: Suggestions for the provided texts.
        ///   - nextCharacterPredictions: Next character predictions for the provided text, if any.
        ///   - isOutdated: Whether the result is outdated and should be ignored, by default `false`.
        public init(
            inputText: String,
            suggestions: [Suggestion],
            nextCharacterPredictions: [Character: Double]? = nil,
            isOutdated: Bool = false
        ) {
            self.inputText = inputText
            self.suggestions = suggestions
            self.nextCharacterPredictions = nextCharacterPredictions
            self.isOutdated = isOutdated
        }

        /// The originally provided text.
        public let inputText: String

        /// Suggestions for the provided texts.
        public let suggestions: [Suggestion]

        /// Next character predictions for the provided text, if any.
        public let nextCharacterPredictions: [Character: Double]?

        /// Whether the result is outdated and should be ignored.
        public let isOutdated: Bool
    }
}
