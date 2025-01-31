//
//  KeyboardFeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type is used for feedback-related settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with a `feedback` prefix.
public struct KeyboardFeedbackSettings {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use for the namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "feedback")
    }

    /// Whether audio feedback is enabled, by default `true`.
    @AppStorage("\(settingsPrefix)isAudioFeedbackEnabled", store: .keyboardSettings)
    public var isAudioFeedbackEnabled = true

    /// Whether haptic feedback is enabled, by default `true`.
    @AppStorage("\(settingsPrefix)isHapticFeedbackEnabled", store: .keyboardSettings)
    public var isHapticFeedbackEnabled = true
}

public extension KeyboardFeedbackSettings {

    /// Toggle audio feedback enabled state.
    func toggleIsAudioFeedbackEnabled() {
        isAudioFeedbackEnabled.toggle()
    }

    /// Toggle haptic feedback enabled state.
    func toggleIsHapticFeedbackEnabled() {
        isHapticFeedbackEnabled.toggle()
    }
}
