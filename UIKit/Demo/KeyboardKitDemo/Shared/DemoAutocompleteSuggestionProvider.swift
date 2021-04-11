//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This demo provider simply returns the current word suffixed
 with "ly", "er" and "ter".
 
 The provider is registered by the input view controller, to
 show you how to can register your own provoder. However, it
 is overwritten by a `StandardAutocompleteSuggestionProvider`
 from KeyboardKit Pro when the demo registers a pro license.
 */
class DemoAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {
    
    var locale: Locale = .current
    
    
    var canIgnoreWords: Bool { false }
    
    var ignoredWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    
    func ignoreWord(_ word: String) {}
    
    func removeIgnoredWord(_ word: String) {}
    
    
    var canLearnWords: Bool { false }
    
    func hasLearnedWord(_ word: String) -> Bool { false }
    
    func learnWord(_ word: String) {}
    
    func unlearnWord(_ word: String) {}
    
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        completion(.success(suggestions(for: text)))
    }
}

private extension DemoAutocompleteSuggestionProvider {
    
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
