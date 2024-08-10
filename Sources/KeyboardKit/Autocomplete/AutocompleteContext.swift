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
/// autocorrect are enabled, while ``isAutoLearnEnabled`` is
/// used to control if a keyboard should automatically learn
/// any unknown suggestions that it applies.
///
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

    /// The number of autocomplete suggestions to display.
    ///
    /// This is stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)suggestionsDisplayCount", store: .keyboardSettings)
    public var suggestionsDisplayCount = 3


    // MARK: - Properties

    /// This localized dictionary can be used to define more,
    /// custom autocorrections for the various locales.
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

    /// Whether or not to auto-learn unknown suggestions.
    @Published
    public var isAutoLearnEnabled = true

    /// Whether or not suggestions are being fetched.
    @Published
    public var isLoading = false

    /// The last received autocomplete error.
    @Published
    public var lastError: Error?

    /// The suggestions to present to the user.
    @Published
    public var suggestions: [Autocomplete.Suggestion] = []

    /// The suggestions returned by an autocomplete service.
    @Published
    public var suggestionsFromService: [Autocomplete.Suggestion] = [] {
        didSet {
            let value = suggestionsFromService
            suggestions = Array(value.prefix(suggestionsDisplayCount))
        }
    }

    /// Reset the autocomplete contexts.
    public func reset() {
        isLoading = false
        lastError = nil
        suggestions = []
    }
}
