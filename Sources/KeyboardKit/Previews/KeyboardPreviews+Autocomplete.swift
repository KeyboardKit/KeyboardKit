//
//  KeyboardPreviews+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteContext {

    static var preview: AutocompleteContext = {
        let context = AutocompleteContext()
        context.suggestions = .preview
        return context
    }()
}

public extension AutocompleteService where Self == KeyboardPreviews.PreviewAutocompleteService {

    static var preview: AutocompleteService {
        preview()
    }

    static func preview(
        suggestions: [Autocomplete.Suggestion] = .preview
    ) -> AutocompleteService {
        KeyboardPreviews.PreviewAutocompleteService(suggestions: suggestions)
    }
}

public extension KeyboardPreviews {
    
    class PreviewAutocompleteService: Autocomplete.DisabledService {}
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
