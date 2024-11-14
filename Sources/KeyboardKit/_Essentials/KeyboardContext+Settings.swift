//
//  KeyboardContext+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-26.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardContext {

    /// This type is used for essential keyboard settings.
    ///
    /// All properties in this type are automatically stored
    /// in ``Foundation/UserDefaults/keyboardSettings`` with
    /// a `keyboard` prefix.
    struct Settings {

        /// Create a custom settings instance.
        ///
        /// - Parameters:
        ///   - onAutocapitalizationEnabledChanged: The action to trigger when autocapitalization is changed.
        public init(
            onAutocapitalizationEnabledChanged: @escaping () -> Void = {}
        ) {
            self.onAutocapitalizationEnabledChanged = onAutocapitalizationEnabledChanged
        }

        private let onAutocapitalizationEnabledChanged: () -> Void

        /// The settings key prefix to use.
        public static var settingsPrefix: String {
            Keyboard.Settings.storeKeyPrefix(for: "keyboard")
        }

        /// A list of explicitly added locale identifiers.
        @AppStorage("\(settingsPrefix)addedLocaleIdentifiers", store: .keyboardSettings)
        public var addedLocaleIdentifiersValues: Keyboard.StorageValue<[String]> = .init(value: [])

        /// Whether autocapitalization is enabled.
        @AppStorage("\(settingsPrefix)isAutocapitalizationEnabled", store: .keyboardSettings)
        public var isAutocapitalizationEnabled = true {
            didSet { onAutocapitalizationEnabledChanged() }
        }

        /// Whether to auto-collapse the keyboard when an external keyboard is connected.
        @AppStorage("\(settingsPrefix)`isKeyboardAutoCollapseEnabled`", store: .keyboardSettings)
        public var isKeyboardAutoCollapseEnabled = false

        /// The identifier of the current ``locale``.
        @AppStorage("\(settingsPrefix)localeIdentifier", store: .keyboardSettings)
        public internal(set) var localeIdentifier = Locale.current.identifier
    }
}


// MARK: - Added locales

extension KeyboardContext.Settings {

    /// A list of explicitly added locales.
    var addedLocales: [Locale] {
        get { addedLocaleIdentifiers.compactMap { Locale(identifier: $0) } }
        set { addedLocaleIdentifiers = newValue.unique().map { $0.identifier } }
    }

    /// A list of explicitly added locale identifiers.
    var addedLocaleIdentifiers: [String] {
        get { addedLocaleIdentifiersValues.value }
        set { addedLocaleIdentifiersValues.value = newValue }
    }

    /// Whether a locale has been added to ``addedLocales``.
    func hasAddedLocale(_ locale: Locale) -> Bool {
        addedLocales.contains(locale)
    }

    /// Move the current ``locale`` first in ``addedLocales``.
    mutating func moveLocaleFirstInAddedLocales(_ locale: Locale) {
        if locale == addedLocales.first { return }
        addedLocales = addedLocales.insertingFirst(locale)
    }
}


// MARK: - Internals

extension KeyboardContext.Settings {

    func updateLocaleIdentifier(_ id: String) {
        guard localeIdentifier != id else { return }
        localeIdentifier = id
    }
}
