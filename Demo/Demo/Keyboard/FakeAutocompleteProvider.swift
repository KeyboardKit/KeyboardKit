//
//  FakeAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This autocomplete provider can be used in the non-pro demos,
 where KeyboardKit Pro standard autocomplete isn't available.

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom autocomplete provider.

 This provider always returns three autocomplete suggestions,
 with the current word suffixed with "-1", "-2" and "-3". It
 also adds a static subtitle to the middle suggestion.

 If the currently typed word is "match" (this can be changed
 in the init) the provider returns another result, where the
 left suggestion is an "unknown" suggestion, the center is a
 highlighted autocomplete suggestion and the right is just a
 regular suggestion without any special look or behavior.
 */
class FakeAutocompleteProvider: AutocompleteProvider {

    init(match: String = "match") {
        self.match = match
    }

    private var match: String
    
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
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        guard text.count > 0 else { return completion(.success([])) }
        if text == match {
            completion(.success(matchSuggestions()))
        } else {
            completion(.success(fakeSuggestions(for: text)))
        }
    }
}

private extension FakeAutocompleteProvider {
    
    func fakeSuggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            StandardAutocompleteSuggestion(text: text + "-1"),
            StandardAutocompleteSuggestion(text: text + "-2", subtitle: "Subtitle"),
            StandardAutocompleteSuggestion(text: text + "-3")
        ]
    }
    
    func fakeSuggestion(_ text: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(text: text, subtitle: subtitle)
    }

    func matchSuggestions() -> [AutocompleteSuggestion] {
        [
            StandardAutocompleteSuggestion(text: match, isUnknown: true),
            StandardAutocompleteSuggestion(text: match, isAutocomplete: true),
            StandardAutocompleteSuggestion(text: match),
        ]
    }
}
