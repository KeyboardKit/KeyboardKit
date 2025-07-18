//
//  FeedbackContext.swift
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
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class FeedbackContext: ObservableObject {

    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// Feedback-specific, auto-persisted settings.
    @Published public var settings: FeedbackSettings


    // MARK: - Typealiases

    public typealias AudioConfiguration = Feedback.AudioConfiguration
    public typealias HapticConfiguration = Feedback.HapticConfiguration


    // MARK: - Properties
    
    /// The audio configuration to use when enabled.
    public var audioConfiguration: AudioConfiguration = .standard

    /// The haptic configuration to use when enabled.
    public var hapticConfiguration: HapticConfiguration = .standard
}

public extension FeedbackContext {

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
