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
    /// All properties in this type are automatically stored
    /// in ``Foundation/UserDefaults/keyboardSettings`` with
    /// a `themes` prefix.
    struct Settings {

        /// Create a custom settings instance.
        public init() {}

        /// The settings key prefix to use for the namespace.
        public static var settingsPrefix: String {
            KeyboardSettings.storeKeyPrefix(for: "themes")
        }

        /// The current theme, if any.
        @AppStorage("\(settingsPrefix)theme", store: .keyboardSettings)
        public var theme: Keyboard.StorageValue<KeyboardTheme?> = .init(value: nil)
    }
}

public extension KeyboardThemeContext.Settings {

    /// Reset the current ``theme``.
    func resetTheme() {
        self.theme.value = nil
    }

    /// Set the current ``theme``.
    func setTheme(_ theme: KeyboardTheme) {
        self.theme.value = theme
    }
}
