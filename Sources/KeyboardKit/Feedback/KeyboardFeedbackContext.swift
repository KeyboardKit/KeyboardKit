//
//  KeyboardFeedbackContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

/// This class has observable states and persistent settings
/// for keyboard feedback.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
///
/// Use the ``audioConfiguration`` and ``hapticConfiguration``
/// to configure which feedback to trigger when the feedback
/// type is enabled. The enabled states for audio and haptic
/// feedback can be found in ``settings``.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
public class KeyboardFeedbackContext: ObservableObject {

    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// Feedback-specific, auto-persisted settings.
    @Published public var settings: KeyboardFeedbackSettings


    // MARK: - Typealiases

    public typealias AudioConfiguration = KeyboardFeedback.AudioConfiguration
    public typealias HapticConfiguration = KeyboardFeedback.HapticConfiguration


    // MARK: - Properties
    
    /// The audio configuration to use when enabled.
    public var audioConfiguration: AudioConfiguration = .standard

    /// The haptic configuration to use when enabled.
    public var hapticConfiguration: HapticConfiguration = .standard
}

public extension KeyboardFeedbackContext {

    /// Register custom audio feedback.
    func registerCustomFeedback(
        _ feedback: AudioConfiguration.CustomFeedback
    ) {
        audioConfiguration.registerCustomFeedback(feedback)
    }
    
    /// Register custom haptic feedback.
    func registerCustomFeedback(
        _ feedback: HapticConfiguration.CustomFeedback
    ) {
        hapticConfiguration.registerCustomFeedback(feedback)
    }
}
