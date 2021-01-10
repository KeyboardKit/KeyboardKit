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
        completion(.success(suggestions(for: text)))
    }
}

public struct DemoAutocompleteSuggestion: AutocompleteSuggestion {
    
    public var replacement: String
    public var title: String { replacement }
    public var subtitle: String?
    public var additionalInfo: [String: Any] { [:] }
}

private extension DemoAutocompleteSuggestionProvider {
    
    func suggestions(for text: String) -> [DemoAutocompleteSuggestion] {
        [
            suggestion(text + "ly"),
            suggestion(text + "er", "primary"),
            suggestion(text + "ter")
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> DemoAutocompleteSuggestion {
        DemoAutocompleteSuggestion(replacement: word, subtitle: subtitle)
    }
}
