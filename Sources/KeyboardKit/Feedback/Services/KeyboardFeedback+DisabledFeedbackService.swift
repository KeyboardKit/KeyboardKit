//
//  KeyboardFeedback+DisabledFeedbackService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardFeedbackService where Self == KeyboardFeedback.DisabledFeedbackService {

    /// Create a disabled feedback service instance.
    static var disabled: Self {
        KeyboardFeedback.DisabledFeedbackService()
    }
}

extension KeyboardFeedback {

    /// This service can be used to disable all feedback.
    ///
    /// This service can also be resolved with the shorthand
    /// ``KeyboardFeedbackService/disabled``.
    ///
    /// See <doc:Feedback-Article> for more information.
    open class DisabledFeedbackService: KeyboardFeedbackService {

        /// Create a disabled feedback service.
        public init() {}

        open func triggerAudioFeedback(_ audio: KeyboardFeedback.Audio) {}

        open func triggerHapticFeedback(_ feedback: KeyboardFeedback.Haptic) {}
    }
}
