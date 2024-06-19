//
//  Autocomplete+DisabledProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {
 
    /// This class is used as the default provider until you
    /// register a custom implementation or register a valid
    /// KeyboardKit Pro license key.
    ///
    /// See <doc:Autocomplete-Article> for more information.
    class DisabledProvider: AutocompleteProvider {
        
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
        ) async throws -> [String : Double] {
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

public extension AutocompleteProvider where Self == Autocomplete.DisabledProvider {
    
    /// This provider can be used to disable autocomplete.
    static var disabled: AutocompleteProvider {
        Autocomplete.DisabledProvider()
    }
}
