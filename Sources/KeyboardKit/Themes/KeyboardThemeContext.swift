//
//  KeyboardThemeContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-29.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class has observable states and persistent settings
/// for keyboard-specific themes.
///
/// The class has observable auto-persisted ``settings`` for
/// e.g. the current ``Settings-swift.struct/theme``. Due to
/// observation-related issues that makes SwiftUI not update
/// when the ``settings`` theme is changed, the theme should
/// be managed through this class and its properties instead.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
public class KeyboardThemeContext: ObservableObject {

    /// Create a keyboard theme context instance.
    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// Theme-specific, auto-persisted settings.
    @Published
    public var settings: Settings

    /// The last theme changed date, if any.
    @Published
    public var themeChanged = Date.now.timeIntervalSince1970
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

    /// Reset the current ``theme``.
    func resetCurrentTheme() {
        setCurrentTheme(nil)
    }

    /// Set the current ``theme``.
    func setCurrentTheme(_ theme: KeyboardTheme?) {
        settings.themeValue.value = theme
        themeChanged = Date.now.timeIntervalSince1970
    }
}
