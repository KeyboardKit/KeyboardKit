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

public extension AutocompleteProvider where Self == KeyboardPreviews.PreviewAutocompleteProvider {

    static var preview: AutocompleteProvider {
        preview()
    }

    static func preview(
        suggestions: [Autocomplete.Suggestion] = .preview
    ) -> AutocompleteProvider {
        KeyboardPreviews.PreviewAutocompleteProvider(suggestions: suggestions)
    }
}

public extension KeyboardPreviews {
    
    class PreviewAutocompleteProvider: Autocomplete.DisabledProvider {}
}

public extension Collection where Element == Autocomplete.Suggestion {
    
    static var preview: [Autocomplete.Suggestion] {
        [
            .init(text: "One", isUnknown: true),
            .init(text: "Two", isAutocorrect: true),
            .init(text: "Three")
        ]
    }
}
