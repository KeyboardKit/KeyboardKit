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
 
 If you target iOS 13 and later, `KeyboardKitSwiftUI` can be
 used instead. It contains an `ObservableAutocompleteContext`
 that has better value binding capabilities.
 */
public class StandardAutocompleteContext: AutocompleteContext {
    
    public init(suggestionsDidChange: @escaping (AutocompleteSuggestions) -> Void) {
        self.suggestions = []
        self.suggestionsDidChange = suggestionsDidChange
    }
    
    private let suggestionsDidChange: (AutocompleteSuggestions) -> Void
    
    public var suggestions: AutocompleteSuggestions {
        didSet { suggestionsDidChange(suggestions) }
    }
}
