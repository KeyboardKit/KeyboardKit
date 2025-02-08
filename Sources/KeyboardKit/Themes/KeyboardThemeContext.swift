//
//  KeyboardThemeContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-29.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class has observable states and persistent settings
/// for keyboard-specific themes.
///
/// This class has observable auto-persisted ``settings`` to
/// handle the current ``KeyboardThemeSettings/theme``.
///
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class KeyboardThemeContext: ObservableObject {

    /// Create a keyboard theme context instance.
    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// Theme-specific, auto-persisted settings.
    @Published public var settings: KeyboardThemeSettings

    /// The last theme changed date, if any.
    @Published public var themeChanged = Date.now.timeIntervalSince1970
}

public extension KeyboardThemeContext {

    /// The current ``settings`` theme.
    var currentTheme: KeyboardTheme? {
        get { settings.theme }
        set { setCurrentTheme(newValue) }
    }

    /// A current ``settings`` theme binding.
    var currentThemeBinding: Binding<KeyboardTheme?> {
        .init {
            self.settings.theme
        } set: { theme in
            self.setCurrentTheme(theme)
        }
    }

    /// Reset the current ``KeyboardThemeSettings/theme``.
    func resetCurrentTheme() {
        setCurrentTheme(nil)
    }

    /// Set the current ``KeyboardThemeSettings/theme``.
    func setCurrentTheme(_ theme: KeyboardTheme?) {
        settings.themeValue.value = theme
        themeChanged = Date.now.timeIntervalSince1970
    }
}
