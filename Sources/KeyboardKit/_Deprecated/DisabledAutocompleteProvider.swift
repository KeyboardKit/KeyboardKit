//
//  DisabledAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public class DeprecatedAutocompleteProvider: AutocompleteProvider {
    
    public init() {}
    
    public var locale: Locale = .current
    
    public func autocompleteSuggestions(for text: String, completion: Completion) {
        completion(.success([]))
    }
    
    public var canIgnoreWords: Bool { false }
    public var canLearnWords: Bool { false }
    public var ignoredWords: [String] = []
    public var learnedWords: [String] = []
    
    public func hasIgnoredWord(_ word: String) -> Bool { false }
    public func hasLearnedWord(_ word: String) -> Bool { false }
    public func ignoreWord(_ word: String) {}
    public func learnWord(_ word: String) {}
    public func removeIgnoredWord(_ word: String) {}
    public func unlearnWord(_ word: String) {}
}

@available(*, deprecated, message: "The controller's autocompleteProvider will become optional in 8.0, at which this will be removed.")
public class DisabledAutocompleteProvider: DeprecatedAutocompleteProvider {}
