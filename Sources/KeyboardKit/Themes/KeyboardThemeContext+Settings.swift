//
//  KeyboardThemeContext+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardThemeContext {

    /// This type is used for theme-related settings.
    ///
    /// Use the ``theme`` property to get the selected theme,
    /// and the ``themeValue`` to get any persisted data.
    ///
    /// For now, the ``KeyboardThemeContext``, since SwiftUI
    /// wasn't properly updated when this struct was changed.
    /// This should be changed when possible, since settings
    /// are meant to be used for persisted settings.
    struct Settings {

        /// Create a custom settings instance.
        public init() {}

        /// The settings key prefix to use for the namespace.
        public static var settingsPrefix: String {
            Keyboard.Settings.storeKeyPrefix(for: "themes")
        }

        /// The current theme, if any.
        public var theme: KeyboardTheme? {
            themeValue.value
        }

        /// The current theme storage value, if any.
        @AppStorage("\(settingsPrefix)theme", store: .keyboardSettings)
        public var themeValue: Keyboard.StorageValue<KeyboardTheme?> = .init(value: nil)
    }
}
