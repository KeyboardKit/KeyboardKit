//
//  KeyboardApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-01.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type can be used to define important properties for
/// your app, and is also a namespace for app-based features.
///
/// You can create a static app value and add it to both the
/// app and its keyboard, to be able to use it in both, e.g.:
///
/// ```swift
/// extension KeyboardApp {
///     static var keyboardKitDemo: Self {
///         .init(
///             name: "KeyboardKit",
///             licenseKey: "abc123",
///             appGroupId: "group.com.keyboardkit.demo",
///             locales: [.english, .swedish, .persian],
///             autocomplete: .init(...),
///             deepLinks: .init(app: "keyboardkit://")
///         )
///     }
/// }
/// ```
///
/// > Important: The ``locales`` specifies which locales you
/// want to enable for the app. You don't have to provide it
/// if you have a KeyboardKit Pro Gold license, since it has
/// all locales enabled. The list is otherwise capped to the
/// amount of locales that your license includes.
public struct KeyboardApp {
    
    /// Create a custom keyboard app value.
    ///
    /// - Parameters:
    ///   - name: The name of the app.
    ///   - licenseKey: Your license key, if any.
    ///   - appGroupId: The app's App Group identifier, if any.
    ///   - locales: The locales to use in the app, by default `.all`.
    ///   - autocomplete: The autocomplete configuration to use.
    ///   - deepLinks: App-specific deep links, if any.
    ///   - keyboardSettingsKeyPrefix: A custom keyboard settings key prefix, if any.
    public init(
        name: String,
        licenseKey: String? = nil,
        appGroupId: String? = nil,
        locales: [Locale] = .keyboardKitSupported,
        autocomplete: AutocompleteConfiguration = .init(),
        deepLinks: DeepLinks? = nil,
        keyboardSettingsKeyPrefix: String? = nil
    ) {
        self.name = name
        self.appGroupId = appGroupId
        self.locales = locales
        self.licenseKey = licenseKey
        self.autocomplete = autocomplete
        self.deepLinks = deepLinks
        self.keyboardSettingsKeyPrefix = keyboardSettingsKeyPrefix
    }
    
    @available(*, deprecated, renamed: "init(name:licenseKey:appGroupId:locales:autocomplete:deepLinks:keyboardSettingsKeyPrefix:)")
    public init(
        name: String,
        licenseKey: String? = nil,
        bundleId: String,
        keyboardBundleId: String? = nil,
        appGroupId: String? = nil,
        locales: [Locale] = .keyboardKitSupported,
        autocomplete: AutocompleteConfiguration = .init(),
        deepLinks: DeepLinks? = nil,
        keyboardSettingsKeyPrefix: String? = nil
    ) {
        self.name = name
        self.bundleId = bundleId
        self.appGroupId = appGroupId
        self.keyboardBundleId = keyboardBundleId ?? "\(bundleId).keyboard"
        self.locales = locales
        self.licenseKey = licenseKey
        self.autocomplete = autocomplete
        self.deepLinks = deepLinks
        self.keyboardSettingsKeyPrefix = keyboardSettingsKeyPrefix
    }

    /// The name of the app.
    public let name: String

    /// Your license key, if any.
    public let licenseKey: String?

    /// The app's App Group identifier, if any.
    public let appGroupId: String?

    /// The locales to use in the app.
    public let locales: [Locale]

    /// App-specific deep links, if any.
    public let deepLinks: DeepLinks?

    /// The autocomplete configuration to use.
    public let autocomplete: AutocompleteConfiguration

    /// A custom keyboard settings key prefix, if any.
    public let keyboardSettingsKeyPrefix: String?
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "This is no longer needed.")
    public var bundleId: String = ""

    @available(*, deprecated, message: "This is no longer needed.")
    public var keyboardBundleId: String = ""
    
    @available(*, deprecated, message: "This is no longer needed.")
    public var keyboardBundleIdWildcard: String { "\(bundleId).*" }
}

public extension KeyboardApp {

    /// This type can define app-specific deep links.
    ///
    /// You only have to provide an `app` url, and can leave
    /// the rest blank to use standard URLs.
    struct AutocompleteConfiguration {

        /// Create a custom autocomplete configuration.
        ///
        /// - Parameters:
        ///   - nextWordPredictionRequest: The next word prediction request to use, if any.
        public init(
            nextWordPredictionRequest: Autocomplete.NextWordPredictionRequest? = nil
        ) {
            self.nextWordPredictionRequest = nextWordPredictionRequest
        }

        /// The next word prediction request to use, if any.
        public let nextWordPredictionRequest: Autocomplete.NextWordPredictionRequest?
    }

    /// This type can define app-specific deep links.
    ///
    /// You only have to provide an `app` url, and can leave
    /// the rest blank, if you want to use standard patterns.
    ///
    /// > Important: You must register your `app` URL scheme
    /// within the app project, for these deep links to work.
    struct DeepLinks: KeyboardModel {

        /// Create a custom keyboard deep links value.
        ///
        /// - Parameters:
        ///   - app: A deep link for opening the app, e.g. `myapp://`.
        ///   - dictation: A deep link for opening the app and starting dictation, by default `myapp://dictation`.
        ///   - keyboardSettings: A deep link for opening the app's keyboard settings screen, by default `myapp://keyboardSettings`.
        ///   - languageSettings: A deep link for opening the app's language settings screen, by default `myapp://languageSettings`.
        ///   - themeSettings: A deep link for opening the app's theme settings screen, by default `myapp://themeSettings`.
        public init(
            app: String,
            dictation: String? = nil,
            keyboardSettings: String? = nil,
            languageSettings: String? = nil,
            themeSettings: String? = nil
        ) {
            self.app = app
            self.dictation = dictation ?? "\(app)dictation"
            self.keyboardSettings = keyboardSettings ?? "\(app)keyboardSettings"
            self.languageSettings = languageSettings ?? "\(app)languageSettings"
            self.themeSettings = themeSettings ?? "\(app)themeSettings"
        }

        /// A deep link for opening the app.
        public let app: String

        /// A deep link for opening the app and starting dictation.
        public let dictation: String

        /// A deep link for opening the app's keyboard settings screen.
        public let keyboardSettings: String

        /// A deep link for opening the app's language settings screen.
        public let languageSettings: String

        /// A deep link for opening the app's theme settings screen.
        public let themeSettings: String
    }
}

public extension KeyboardApp.DeepLinks {

    /// A deep link for opening the app.
    var appURL: URL? { .init(string: app) }

    /// A deep link for opening the app and starting dictation.
    var dictationURL: URL? { .init(string: dictation) }

    /// A deep link for opening the app's keyboard settings screen.
    var keyboardSettingsURL: URL? { .init(string: keyboardSettings) }

    /// A deep link for opening the app's language settings screen.
    var languageSettingsURL: URL? { .init(string: languageSettings) }

    /// A deep link for opening the app's theme settings screen.
    var themeSettingsURL: URL? { .init(string: themeSettings) }
}

private extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            licenseKey: "abc123",
            appGroupId: "group.com.keyboardkit.demo",
            locales: [.english, .swedish, .persian]
        )
    }
}
