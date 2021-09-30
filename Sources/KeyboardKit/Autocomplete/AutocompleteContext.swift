//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Combine

/**
 This is an observable class that can be used to store a set
 of autocomplete suggestions.
 
 `KeyboardKit` will automatically create an instance of this
 class and bind it to the input view controller.
 */
public class AutocompleteContext: ObservableObject {
    
    public init() {}
    
    @Published public var isLoading = false
    @Published public var suggestions: [AutocompleteSuggestion] = []
}
