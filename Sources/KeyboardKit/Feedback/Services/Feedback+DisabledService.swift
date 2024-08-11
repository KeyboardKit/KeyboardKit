//
//  Feedback+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Feedback {

    /// This service can be used to disable all feedback.
    ///
    /// See <doc:Feedback-Article> for more information.
    open class DisabledService: FeedbackService {

        /// Create a disabled feedback service.
        public init() {}

        open func triggerAudioFeedback(_ audio: Feedback.Audio) {}

        open func triggerHapticFeedback(_ feedback: Feedback.Haptic) {}
    }
}
