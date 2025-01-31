//
//  KeyboardThemeSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type is used for theme-related settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with a `themes` prefix.
///
/// Use the ``theme`` property to get the selected theme. It
/// will persist values using the ``themeValue`` property.
///
/// > Important: Due to an observation issue that caused the
/// SwiftUI views to not update when a ``theme`` was changed,
/// the context can also be used to change the theme for now.
public struct KeyboardThemeSettings {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use for the namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "themes")
    }

    /// The current theme, if any.
    public var theme: KeyboardTheme? {
        themeValue.value
    }

    /// The current theme storage value, if any.
    @AppStorage("\(settingsPrefix)theme", store: .keyboardSettings)
    public var themeValue: Keyboard.StorageValue<KeyboardTheme?> = .init(value: nil)
}
