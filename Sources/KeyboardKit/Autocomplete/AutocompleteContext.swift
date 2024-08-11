//
//  ObservableAutocompleteContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/// This class has observable states and persistent settings.
///
/// The ``suggestions`` property is automatically updated as
/// the user types or the current text changes. The property
/// honors ``suggestionsDisplayCount`` by capping the number
/// of suggestions in ``suggestionsFromService``.
///
/// The ``isAutocompleteEnabled`` and ``isAutocorrectEnabled``
/// settings can be used to control whether autocomplete and
/// autocorrect are enabled. A ``KeyboardInputViewController``
/// will however check even more places before performing it.
///
/// The ``isAutolearnEnabled`` settings property can be used
/// to control if the keyboard should auto-learn any unknown
/// suggestions that are applied, provided that your service
/// supports learning suggestions.
///
/// The ``isNextCharacterPredictionEnabled`` settings can be
/// used to control if the keyboard should perform character
/// predictions after the main autocomplete operation, which
/// will then be written to ``nextCharacterPredictions``.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value
/// into the view hierarchy.
public class AutocompleteContext: ObservableObject {

    public init() {}


    // MARK: - Settings

    /// The settings key prefix to use for this namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "autocomplete")
    }

    /// Whether autocomplete is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isAutocompleteEnabled", store: .keyboardSettings)
    public var isAutocompleteEnabled = true

    /// Whether autocorrect is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isAutocorrectEnabled", store: .keyboardSettings)
    public var isAutocorrectEnabled = true

    /// Whether to applied unknown suggestions that are used.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isAutolearnEnabled", store: .keyboardSettings)
    public var isAutolearnEnabled = true

    /// Whether next character prediction is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isNextWordPrediction", store: .keyboardSettings)
    public var isNextCharacterPredictionEnabled = true

    /// The number of autocomplete suggestions to display.
    ///
    /// This is stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)suggestionsDisplayCount", store: .keyboardSettings)
    public var suggestionsDisplayCount = 3


    // MARK: - Properties

    /// This localized dictionary can be used to define more,
    /// custom autocorrections for the various locales.
    ///
    /// Note that it's already initialized with a well-known
    /// set of autocorrections, so make sure to append to it.
    @Published
    public var autocorrectDictionary = Autocomplete.TextReplacementDictionary.additionalAutocorrections

    /// Whether or not suggestions are being fetched.
    @Published
    public var isLoading = false

    /// The last received autocomplete error.
    @Published
    public var lastError: Error?

    /// The characters that are more likely to be typed next.
    @Published
    public var nextCharacterPredictions: [Character: Double] = [:]

    /// The suggestions to present to the user.
    @Published
    public var suggestions: [Autocomplete.Suggestion] = []

    /// The suggestions returned by an autocomplete service.
    @Published
    public var suggestionsFromService: [Autocomplete.Suggestion] = [] {
        didSet {
            let value = suggestionsFromService
            let capped = value.prefix(suggestionsDisplayCount)
            suggestions = Array(capped)
        }
    }

    /// Reset the autocomplete contexts.
    public func reset() {
        isLoading = false
        lastError = nil
        suggestions = []
    }
}
