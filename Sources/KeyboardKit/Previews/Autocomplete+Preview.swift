//
//  Autocomplete+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteProvider where Self == PreviewAutocompleteProvider {

    /// This provider can be used in SwiftUI previews.
    static var preview: AutocompleteProvider {
        preview(suggestions: [])
    }

    /// This provider can be used in SwiftUI previews.
    static func preview(
        suggestions: [AutocompleteSuggestion]
    ) -> AutocompleteProvider {
        PreviewAutocompleteProvider(suggestions: suggestions)
    }
}

/// This provider can be used in SwiftUI previews.
public class PreviewAutocompleteProvider: AutocompleteProvider {

    public init(
        suggestions: [AutocompleteSuggestion]
    ) {
        self.suggestions = suggestions
    }
    
    public var locale: Locale = .current
    public let suggestions: [AutocompleteSuggestion]

    public func autocompleteSuggestions(
        for text: String,
        completion: Completion
    ) {
        completion(.success(suggestions))
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
