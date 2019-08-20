//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 
 This demo autocomplete suggestion provider just returns the
 current word suffixed with three, static two-char strings.
 
 */
class DemoAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {

    func provideAutocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        let suffixes = ["ly", "er", "ter"]
        let suggestions = suffixes.map { text + $0 }
        completion(.success(suggestions))
    }
}
