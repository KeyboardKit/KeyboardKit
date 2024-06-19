//
//  Autocomplete+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This service is used as a default service, until you
    /// setup KeyboardKit Pro or register a custom service.
    ///
    /// See <doc:Autocomplete-Article> for more information.
    class DisabledService: AutocompleteService {

        public init(
            suggestions: [Autocomplete.Suggestion] = []
        ) {
            self.suggestions = suggestions
        }

        public var locale: Locale = .current
        public internal(set) var suggestions: [Autocomplete.Suggestion]

        public func autocompleteSuggestions(
            for text: String
        ) async throws -> [Autocomplete.Suggestion] {
            suggestions
        }

        public func nextCharacterPredictions(
            forText text: String,
            suggestions: [Autocomplete.Suggestion]
        ) async throws -> [Character: Double] {
            [:]
        }

        public var canIgnoreWords: Bool { false }
        public var canLearnWords: Bool { false }
        public var ignoredWords: [String] = []
        public var learnedWords: [String] = []

        public func hasIgnoredWord(_ word: String) -> Bool { false }
        public func hasLearnedWord(_ word: String) -> Bool { false }
        public func ignoreWord(_ word: String) {}
        public func learnWord(_ word: String) {}
        public func removeIgnoredWord(_ word: String) {}
        public func unlearnWord(_ word: String) {}
    }
}

public extension AutocompleteService where Self == Autocomplete.DisabledService {

    /// This service can be used to disable autocomplete.
    static var disabled: AutocompleteService {
        Autocomplete.DisabledService()
    }
}
