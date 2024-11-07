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

        /// Whether to autolearn unknown suggestions, by default `true`.
        @AppStorage("\(settingsPrefix)isAutolearnEnabled", store: .keyboardSettings)
        public var isAutolearnEnabled = true

        /// Whether to automatically ignore adjusted suggestions, by default `true`.
        @AppStorage("\(settingsPrefix)isAutoIgnoreEnabled", store: .keyboardSettings)
        public var isAutoIgnoreEnabled = true

        /// Whether next character prediction is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isNextWordPredictionEnabled", store: .keyboardSettings)
        public var isNextCharacterPredictionEnabled = true

        /// The number of autocomplete suggestions to display, by default `3`.
        @AppStorage("\(settingsPrefix)suggestionsDisplayCount", store: .keyboardSettings)
        public var suggestionsDisplayCount = 3
    }
}
