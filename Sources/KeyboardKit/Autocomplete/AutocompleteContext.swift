//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/// This class has observable states and persistent settings
/// for keyboard autocomplete.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
///
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class AutocompleteContext: ObservableObject {

    /// Create an autocomplete context instance.
    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// Auto-persisted autocomplete settings.
    @Published public var settings: AutocompleteSettings
    
    
    // MARK: - Errors

    /// The last received autocomplete error.
    public var lastError: Error?
    

    // MARK: - Published Properties

    /// This localized dictionary can be used to define more,
    /// custom autocorrections for the various locales.
    ///
    /// Note that it's already initialized with a well-known
    /// set of autocorrections, so make sure to append to it.
    @Published public var autocorrectDictionary = Autocomplete.TextReplacementDictionary.additionalAutocorrections

    /// Whether or not suggestions are being fetched.
    @Published public var isLoading = false
    
    /// The characters that are more likely to be typed next.
    @Published public var emojiSuggestions: [Autocomplete.Suggestion] = []

    /// The characters that are more likely to be typed next.
    @Published public var nextCharacterPredictions: [Character: Double] = [:]

    /// The suggestions that should be presented to the user.
    @Published public var suggestions: [Autocomplete.Suggestion] = []

    /// The suggestions that were returned by the service.
    @Published public var suggestionsFromService: [Autocomplete.Suggestion] = [] {
        didSet {
            let value = suggestionsFromService
            let capped = value.prefix(settings.suggestionsDisplayCount)
            suggestions = Array(capped)
        }
    }
}


// MARK: - Public Functions

public extension AutocompleteContext {

    /// Reset the context.
    func reset() {
        update(with: .init(inputText: "", suggestions: [], nextCharacterPredictions: [:]))
    }

    /// Update the context with a certain result.
    func update(with result: Autocomplete.ServiceResult) {
        if result.isOutdated { return }
        DispatchQueue.main.async {
            self.isLoading = false
            self.lastError = nil
            self.suggestionsFromService = result.suggestions
            self.emojiSuggestions = result.emojiSuggestions ?? []
            self.nextCharacterPredictions = result.nextCharacterPredictions ?? [:]
        }
    }

    /// Update the context with a certain error.
    func update(with error: Error) {
        reset()
        DispatchQueue.main.async {
            self.lastError = error
        }
    }
}


// MARK: - Next Character Predictions

public extension AutocompleteContext {

    /// Get a 0-1 next character prediction for a `char`.
    func nextCharacterPrediction(for char: String) -> Double {
        guard
            let first = char.first,
            let value = nextCharacterPredictions[first]
        else { return 0 }
        return value
    }

    /// Get a 0-1 next character prediction for an `action`.
    func nextCharacterPrediction(for action: KeyboardAction) -> Double {
        switch action {
        case .character(let char): nextCharacterPrediction(for: char)
        default: 0
        }
    }
}
