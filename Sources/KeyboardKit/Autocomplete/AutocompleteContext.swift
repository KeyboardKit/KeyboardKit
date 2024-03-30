//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Combine

/// This class has observable, autocomplete-related state.
///
/// The ``suggestions`` property can be updated whenever the
/// user types on the keyboard or the current text selection
/// changes. The ``KeyboardInputViewController`` will handle
/// this automatically, with the ``AutocompleteProvider`` in
/// ``KeyboardInputViewController/services``.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value
/// into the view hierarchy. 
public class AutocompleteContext: ObservableObject {
    
    public init() {}
    
    /// Whether or not autocorrect is enabled.
    @Published
    public var isAutocorrectEnabled = true
    
    /// Whether or not autocomplete is enabled.
    @Published
    public var isAutocompleteEnabled = true

    /// Whether or not suggestions are being fetched.
    @Published
    public var isLoading = false

    /// The last received autocomplete error.
    @Published
    public var lastError: Error?
    
    /// The last received autocomplete suggestions.
    @Published
    public var suggestions: [Autocomplete.Suggestion] = []

    /// Reset the autocomplete contexts.
    public func reset() {
        isLoading = false
        lastError = nil
        suggestions = []
    }
}
