//
//  MockAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

class MockAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current
    
    var autocompleteSuggestionsResult = CompletionResult.success([])
    
    func autocompleteSuggestions(for text: String, completion: Completion) {
        completion(autocompleteSuggestionsResult)
    }
    
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
}
