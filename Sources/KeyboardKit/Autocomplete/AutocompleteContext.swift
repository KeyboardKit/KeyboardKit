//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Combine

/**
 This is an observab le class that can be used to store a set
 of autocomplete suggestions.

 KeyboardKit automatically creates an instance of this class
 and binds the created instance to the keyboard controller's
 ``KeyboardInputViewController/autocompleteContext``.
 */
public class AutocompleteContext: ObservableObject {
    
    public init() {}

    /**
     Whether or not autocomplete is enabled.
     */
    @Published
    public var isEnabled = true

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


    /**
     Reset the autocomplete contexts.
     */
    public func reset() {
        isLoading = false
        lastError = nil
        suggestions = []
    }
}
