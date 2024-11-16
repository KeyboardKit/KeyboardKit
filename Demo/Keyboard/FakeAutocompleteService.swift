//
//  FakeAutocompleteService.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-02-07.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/// This fake service provides fake suggestions while typing,
/// to make the demo show words in the toolbar.
class FakeAutocompleteService: AutocompleteService {

    init(context: AutocompleteContext) {
        self.context = context
    }

    private var context: AutocompleteContext
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}

    func autocomplete(
        _ text: String
    ) async throws -> KeyboardKit.Autocomplete.ServiceResult {
        let word = text.wordFragmentAtEnd
        if word.isEmpty { return .init(inputText: text, suggestions: []) }
        let autocorrect = context.settings.isAutocorrectEnabled
        let suggestions = fakeSuggestions(for: word)
            .withAutocorrectEnabled(autocorrect)
        return .init(inputText: text, suggestions: suggestions)
    }

    func nextCharacterPredictions(
        forText text: String,
        suggestions: [Autocomplete.Suggestion]
    ) async throws -> [Character : Double] {
        [:]
    }
}

private extension FakeAutocompleteService {

    func fakeSuggestions(for text: String) -> [Autocomplete.Suggestion] {
        let suggestions: [Autocomplete.Suggestion] = [
            .init(text: text, type: .unknown),
            .init(text: text, type: .autocorrect),
            .init(text: text, subtitle: "Subtitle"),
            .init(text: "4th Suggestion"),
            .init(text: "5th Suggestion")
        ]
        return Array(suggestions.prefix(context.settings.suggestionsDisplayCount))
    }
}
