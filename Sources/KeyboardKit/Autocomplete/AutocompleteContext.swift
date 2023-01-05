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
 
 KeyboardKit automatically creates an instance of this class
 and sets ``KeyboardInputViewController/autocompleteContext``
 to the instance when a keyboard extension is started.
 */
public class AutocompleteContext: ObservableObject {
    
    public init() {}

    /**
     Whether or not suggestions are currently being fetched.
     */
    @Published
    public var isLoading = false

    /**
     The last received autocomplete error.
     */
    @Published
    public var lastError: Error?
    
    /**
     The last received autocomplete suggestions.
     */
    @Published
    public var suggestions: [AutocompleteSuggestion] = []
}
