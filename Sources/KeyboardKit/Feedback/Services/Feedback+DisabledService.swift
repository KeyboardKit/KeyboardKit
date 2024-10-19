//
//  Feedback+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension FeedbackService where Self == Feedback.DisabledService {

    /// Create a ``Feedback/DisabledService`` instance.
    static var disabled: Self {
        Feedback.DisabledService()
    }
}

extension Feedback {

    /// This service can be used to disable all feedback.
    ///
    /// This service can also be resolved with the shorthand
    /// ``FeedbackService/disabled``.
    ///
    /// See <doc:Feedback-Article> for more information.
    open class DisabledService: FeedbackService {

        /// Create a disabled feedback service.
        public init() {}

        open func triggerAudioFeedback(_ audio: Feedback.Audio) {}

        open func triggerHapticFeedback(_ feedback: Feedback.Haptic) {}
    }
}
