//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo provider simply returns the current word suffixed
 with "ly", "er" and "ter".
 
 This class is shared between the demo app and all keyboards.
 */
class DemoAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        let suffixes = ["ly", "er", "ter"]
        let suggestions = suffixes.map { text + $0 }
        completion(.success(suggestions))
    }
}
