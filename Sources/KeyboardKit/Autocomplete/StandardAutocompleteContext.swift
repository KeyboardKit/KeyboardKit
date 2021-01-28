//
//  AutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class lets you store autocomplete suggestions. It will
 call the provided `suggestionsDidChange` block whenever the
 suggestion collection changes.
 */
public class StandardAutocompleteContext: AutocompleteContext {
    
    public init(suggestionsDidChange: @escaping ([AutocompleteSuggestion]) -> Void) {
        self.suggestions = []
        self.suggestionsDidChange = suggestionsDidChange
    }
    
    private let suggestionsDidChange: ([AutocompleteSuggestion]) -> Void
    
    public var suggestions: [AutocompleteSuggestion] {
        didSet { suggestionsDidChange(suggestions) }
    }
}
