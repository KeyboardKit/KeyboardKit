//
//  DemoAutocompleteSuggestionProvider.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo autocomplete suggestion provider just returns the
 current word suffixed with "ly", "er" and "ter".
 
 This provided takes a context, which it updates whenever it
 performs an autocomplete operation. This simplifies binding
 the result to the view hierarchy without requiring a middle
 layer to coordinate things. In the `UIKit` demo, a standard
 context is used with a completion block, which the `SwiftUI`
 demo uses an observable context.
 */
class DemoAutocompleteSuggestionProvider: AutocompleteSuggestionProvider {
    
    init(context: AutocompleteContext) {
        self.context = context
    }
    
    private let context: AutocompleteContext

    func autocompleteSuggestions(for text: String, completion: AutocompleteResponse) {
        guard text.count > 0 else { return completion(.success([])) }
        let suffixes = ["ly", "er", "ter"]
        let suggestions = suffixes.map { text + $0 }
        context.suggestions = suggestions
        completion(.success(suggestions))
    }
}
