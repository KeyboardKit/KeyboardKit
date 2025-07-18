//
//  Feedback+StandardFeedbackService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension FeedbackService where Self == Feedback.StandardFeedbackService {

    /// Create a standard feedback service instance.
    static var standard: Self {
        Feedback.StandardFeedbackService()
    }
}

extension Feedback {

    /// This standard service can be used to trigger various
    /// audio and haptic feedback, using system capabilities.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// This service can also be resolved with the shorthand
    /// ``FeedbackService/standard``.
    open class StandardFeedbackService: FeedbackService {

        /// Create a standard feedback service.
        public init() {}

        /// The audio feedback engine to use.
        public lazy var audioEngine = Feedback.AudioEngine()

        /// The haptic feedback engine to use.
        public lazy var hapticEngine = Feedback.HapticEngine()

        open func triggerAudioFeedback(_ feedback: Feedback.Audio) {
            audioEngine.trigger(feedback)
        }

        open func triggerHapticFeedback(_ feedback: Feedback.Haptic) {
            hapticEngine.trigger(feedback)
        }
    }
}
