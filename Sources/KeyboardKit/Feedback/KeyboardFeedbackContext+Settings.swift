//
//  KeyboardFeedbackContext+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardFeedbackContext {

    /// This type is used for feedback-related settings.
    ///
    /// All properties in this type are automatically stored
    /// in ``Foundation/UserDefaults/keyboardSettings`` with
    /// a `feedback` prefix.
    struct Settings {

        /// Create a custom settings instance.
        public init() {}

        /// The settings key prefix to use for the namespace.
        public static var settingsPrefix: String {
            Keyboard.Settings.storeKeyPrefix(for: "feedback")
        }

        /// Whether audio feedback is enabled, by default `true`.
        @AppStorage("\(settingsPrefix)isAudioFeedbackEnabled", store: .keyboardSettings)
        public var isAudioFeedbackEnabled = true

        /// Whether haptic feedback is enabled, by default `false`.
        @AppStorage("\(settingsPrefix)isHapticFeedbackEnabled", store: .keyboardSettings)
        public var isHapticFeedbackEnabled = false
    }
}

public extension KeyboardFeedbackContext.Settings {

    /// Toggle audio feedback enabled state.
    func toggleIsAudioFeedbackEnabled() {
        isAudioFeedbackEnabled.toggle()
    }

    /// Toggle haptic feedback enabled state.
    func toggleIsHapticFeedbackEnabled() {
        isHapticFeedbackEnabled.toggle()
    }
}
