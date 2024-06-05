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

    /// This localized dictionary can be used to define your
    /// own custom autocorrections for various locales.
    ///
    /// Note that the collection is already initialized with
    /// a set of well-known autocorrections, so make sure to
    /// append to it instead of replacing what's in it.
    ///
    /// This dictionary is used by the standard autocomplete
    /// provider in KeyboardKit Pro, to match a current text
    /// with an autocorrect suggestion.
    @Published
    public var autocorrectDictionary = Autocomplete.TextReplacementDictionary.additionalAutocorrections

    /// Whether or not autocorrect is enabled.
    @Published
    public var isAutocorrectEnabled = true
    
    /// Whether or not autocomplete is enabled.
    @Published
    public var isAutocompleteEnabled = true
    
    /// Whether or not unknown suggestions are automatically
    /// learned when they're applied.
    @Published
    public var isAutoLearnEnabled = true

    /// Whether or not suggestions are being fetched.
    @Published
    public var isLoading = false

    /// The last received autocomplete error.
    @Published
    public var lastError: Error?

    /// The preferred suggestion count.
    @Published
    public var preferredSuggestionCount: Int = 3

    /// The list of suggestions to present to the user.
    @Published
    public var suggestions: [Autocomplete.Suggestion] = []

    /// Reset the autocomplete contexts.
    public func reset() {
        isLoading = false
        lastError = nil
        suggestions = []
    }
}
