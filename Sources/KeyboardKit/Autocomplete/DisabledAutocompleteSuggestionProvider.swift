//
//  DisabledAutocompleteSuggestionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This private class is used as a placeholder provider, until
 a real provider is injected.
 */
private class DisabledAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {
    
    var locale: Locale = .current
    
    func autocompleteSuggestions(for text: String, completion: (AutocompleteResult) -> Void) {
        completion(.success([]))
    }
    
    var canIgnoreWords: Bool { false }
    
    var ignoredWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    
    func ignoreWord(_ word: String) {}
    
    func removeIgnoredWord(_ word: String) {}
    
    var canLearnWords: Bool { false }
    
    func hasLearnedWord(_ word: String) -> Bool { false }
    
    func learnWord(_ word: String) {}
    
    func unlearnWord(_ word: String) {}
}
