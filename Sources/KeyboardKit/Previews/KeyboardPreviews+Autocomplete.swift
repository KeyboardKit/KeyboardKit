//
//  KeyboardPreviews+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-09.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteContext {

    static var preview: AutocompleteContext = {
        let context = AutocompleteContext()
        context.suggestions = .preview
        return context
    }()
}

public extension AutocompleteService where Self == KeyboardPreviews.AutocompleteService {

    static var preview: AutocompleteService {
        preview()
    }

    static func preview(
        suggestions: [Autocomplete.Suggestion] = .preview
    ) -> AutocompleteService {
        KeyboardPreviews.AutocompleteService(suggestions: suggestions)
    }
}

public extension KeyboardPreviews {
    
    class AutocompleteService: Autocomplete.DisabledAutocompleteService {}
}

public extension Collection where Element == Autocomplete.Suggestion {
    
    static var preview: [Autocomplete.Suggestion] {
        [
            .init(text: "One", type: .unknown),
            .init(text: "Two", type: .autocorrect),
            .init(text: "Three")
        ]
    }
}
