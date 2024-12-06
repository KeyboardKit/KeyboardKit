//
//  AutocompleteContext+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension AutocompleteContext {

    /// This type is used for autocomplete-related settings.
    ///
    /// The ``isNextWordPredictionEnabled`` setting is false
    /// by default, since users must explicitly approve that
    /// their typed text is sent to a 3rd party service.
    ///
    /// You can use the ``nextWordPredictionRequestType`` to
    /// let your users select which request type to use, and
    /// ``nextWordPredictionRequestApiKey`` to define an API
    /// key, for when you don't want to use your own API key.
    ///
    /// KeyboardKit Pro's ``KeyboardApp/SettingsScreen`` has
    /// an visibility setting to enable a separate next word
    /// prediction section, which by default is hidden.
    ///
    /// All properties in this type are automatically stored
    /// in ``Foundation/UserDefaults/keyboardSettings`` with
    /// an `autocomplete` prefix.
    struct Settings {

        /// Create a custom settings instance.
        public init() {}

        /// The settings key prefix to use.
        public static var settingsPrefix: String {
            Keyboard.Settings.storeKeyPrefix(for: "autocomplete")
        }

        /// Whether autocomplete is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isAutocompleteEnabled", store: .keyboardSettings)
        public var isAutocompleteEnabled = true

        /// Whether autocorrect is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isAutocorrectEnabled", store: .keyboardSettings)
        public var isAutocorrectEnabled = true

        /// Whether to autolearn unknown suggestions, by default `false`.
        @AppStorage("\(settingsPrefix)isAutolearnEnabled", store: .keyboardSettings)
        public var isAutolearnEnabled = false

        /// Whether to automatically ignore adjusted suggestions, by default `true`.
        @AppStorage("\(settingsPrefix)isAutoIgnoreEnabled", store: .keyboardSettings)
        public var isAutoIgnoreEnabled = true

        /// Whether next character prediction is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isNextCharacterPredictionEnabled", store: .keyboardSettings)
        public var isNextCharacterPredictionEnabled = true

        /// Whether next word prediction is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isNextWordPredictionEnabled", store: .keyboardSettings)
        public var isNextWordPredictionEnabled = true

        /// A custom, user-specified next word predicton request API key.
        @AppStorage("\(settingsPrefix)nextWordPredictionApiKey", store: .keyboardSettings)
        public var nextWordPredictionRequestApiKey = ""

        /// A custom, user-specified next word predicton request type.
        @AppStorage("\(settingsPrefix)nextWordPredictionRequestType", store: .keyboardSettings)
        public var nextWordPredictionRequestType = Autocomplete.NextWordPredictionRequestType.claude

        /// The number of autocomplete suggestions to display, by default `3`.
        @AppStorage("\(settingsPrefix)suggestionsDisplayCount", store: .keyboardSettings)
        public var suggestionsDisplayCount = 3
    }
}
