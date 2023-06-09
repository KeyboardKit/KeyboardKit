//
//  Autocomplete+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteProvider where Self == PreviewAutocompleteProvider {

    /**
     This preview provider can be used in SwiftUI previews.
     */
    static var preview: AutocompleteProvider {
        preview(suggestions: [])
    }

    /**
     This preview provider can be used in SwiftUI previews.
     */
    static func preview(
        suggestions: [AutocompleteSuggestion]
    ) -> AutocompleteProvider {
        PreviewAutocompleteProvider(suggestions: suggestions)
    }
}

/**
 This autocomplete provider can be used in SwiftUI previews.
 */
public class PreviewAutocompleteProvider: DisabledAutocompleteProvider {

    /**
     Create a preview provider with a set of suggestions.
     */
    public init(
        suggestions: [AutocompleteSuggestion]
    ) {
        self.suggestions = suggestions
        super.init()
    }

    public let suggestions: [AutocompleteSuggestion]

    public override func autocompleteSuggestions(
        for text: String,
        completion: (AutocompleteResult) -> Void
    ) {
        completion(.success(suggestions))
    }
}
