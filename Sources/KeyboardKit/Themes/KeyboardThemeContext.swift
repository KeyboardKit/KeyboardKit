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
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
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
}
