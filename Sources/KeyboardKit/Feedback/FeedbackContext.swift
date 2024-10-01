//
//  FeedbackContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

/// This class has observable states and persistent settings.
///
/// Use the ``audioConfiguration`` and ``hapticConfiguration``
/// properties to configure which feedback to trigger when a
/// certain action is triggered. The configurations are only
/// used when feedback is enabled.
///
/// ``isAudioFeedbackEnabled`` and ``isHapticFeedbackEnabled``
/// are auto-persisted and can be used to toggle feedback on
/// and off. You can also use the handy toggle functions and.
/// use the `register` functions to register custom feedback.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
public class FeedbackContext: ObservableObject {
    
    public init() {}


    // MARK: - Settings

    /// The settings key prefix to use for this namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "feedback")
    }

    /// Whether audio feedback is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isAudioFeedbackEnabled", store: .keyboardSettings)
    public var isAudioFeedbackEnabled = true

    /// Whether haptic feedback is enabled.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)isHapticFeedbackEnabled", store: .keyboardSettings)
    public var isHapticFeedbackEnabled = false


    // MARK: - Properties

    /// The configuration to use for audio feedback.
    public var audioConfiguration: Feedback.AudioConfiguration {
        get { isAudioFeedbackEnabled ? enabledAudioConfiguration : .disabled }
        set { enabledAudioConfiguration = newValue }
    }
    
    /// The configuration to use for haptic feedback.
    public var hapticConfiguration: Feedback.HapticConfiguration {
        get { isHapticFeedbackEnabled ? enabledHapticConfiguration : .disabled }
        set { enabledHapticConfiguration = newValue }
    }
    
    /// The audio configuration to use when enabled.
    var enabledAudioConfiguration: Feedback.AudioConfiguration = .enabled

    /// The haptic configuration to use when enabled.
    var enabledHapticConfiguration: Feedback.HapticConfiguration = .enabled
}

public extension FeedbackContext {
    
    /// Register custom audio feedback.
    func registerCustomFeedback(
        _ feedback: Feedback.AudioConfiguration.CustomFeedback
    ) {
        audioConfiguration.registerCustomFeedback(feedback)
    }
    
    /// Register custom haptic feedback.
    func registerCustomFeedback(
        _ feedback: Feedback.HapticConfiguration.CustomFeedback
    ) {
        hapticConfiguration.registerCustomFeedback(feedback)
    }

    /// Toggle audio feedback enabled state.
    func toggleIsAudioFeedbackEnabled() {
        isAudioFeedbackEnabled.toggle()
    }

    /// Toggle haptic feedback enabled state.
    func toggleIsHapticFeedbackEnabled() {
        isHapticFeedbackEnabled.toggle()
    }
}
