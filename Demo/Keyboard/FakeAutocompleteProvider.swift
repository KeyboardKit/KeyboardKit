//
//  FakeAutocompleteProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-02-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This autocomplete provider is used in the non-pro demos, to
 show fake suggestions since KeyboardKit Pro autocomplete is
 not available.

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom autocomplete provider.

 This provider always returns three autocomplete suggestions,
 with the current word suffixed with "-1", "-2" and "-3".

 If the current word is `match` (this can be changed in init)
 the leading suggestion will be an "unknown" suggestion, the
 center one highlighted and the trailing one regular.
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
    
    func autocompleteSuggestions(
        for text: String,
        completion: AutocompleteProvider.Completion
    ) {
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
            AutocompleteSuggestion(text: text + "-1"),
            AutocompleteSuggestion(text: text + "-2", subtitle: "Subtitle"),
            AutocompleteSuggestion(text: text + "-3")
        ]
    }
    
    func fakeSuggestion(_ text: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        AutocompleteSuggestion(text: text, subtitle: subtitle)
    }

    func matchSuggestions() -> [AutocompleteSuggestion] {
        [
            AutocompleteSuggestion(text: match, isUnknown: true),
            AutocompleteSuggestion(text: match, isAutocorrect: true),
            AutocompleteSuggestion(text: match),
        ]
    }
}
