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
 This fake provider simply returns the current word suffixed
 with "ly", "er" and "ter".
 
 This provider is registered by `KeyboardViewController`, to
 show you how to can register your own provider. However, if
 the demo registers KeyboardKit Pro as well, the provider is
 replaced with a `StandardAutocompleteProvider`.
 */
class FakeAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var ignoredWords: [String] = []
    var canLearnWords: Bool { false }
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        completion(.success(suggestions(for: text)))
    }
}

private extension FakeAutocompleteProvider {
    
    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            suggestion(text + "ly"),
            suggestion(text + "er", "Subtitle"),
            suggestion(text + "ter")
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(text: word, title: word, subtitle: subtitle)
    }
}
