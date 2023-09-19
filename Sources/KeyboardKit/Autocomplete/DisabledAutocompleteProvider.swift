//
//  DisabledAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider can be used to disable autocomplete.
 */
public class DisabledAutocompleteProvider: AutocompleteProvider {
    
    public init() {}
    
    public var locale: Locale = .current
    
    public func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        []
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

public extension AutocompleteProvider where Self == DisabledAutocompleteProvider {
    
    /// This provider can be used to disable autocomplete.
    static var disabled: AutocompleteProvider {
        DisabledAutocompleteProvider()
    }
}
