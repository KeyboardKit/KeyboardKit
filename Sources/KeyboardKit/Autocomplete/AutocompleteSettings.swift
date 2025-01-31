//
//  AutocompleteSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type provides autocomplete-related settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with an `autocomplete` prefix.
///
/// The ``isNextWordPredictionEnabled`` property is false by
/// default, since users should approve that text is sent to
/// a 3rd party service. When it's enabled, you can define a
/// request type with ``nextWordPredictionRequestType``, and
/// define API key using ``nextWordPredictionRequestApiKey``.
///
/// You can also expose these settings to your users, to let
/// them choose their own service accounts. This is a way to
/// let your users pay for their own data. KeyboardKit Pro's
/// ``KeyboardApp/SettingsScreen`` has visibility toggles to
/// show and hide a next word prediction section.
public struct AutocompleteSettings {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "autocomplete")
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
