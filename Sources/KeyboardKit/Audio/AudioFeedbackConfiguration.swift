//
//  AudioFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//

import Foundation

/**
 This configuration struct specifies an audio feedback setup
 for custom keyboards.
 */
public struct AudioFeedbackConfiguration {
    
    public init(
        inputFeedback: AudioFeedback,
        deleteFeedback: AudioFeedback,
        systemFeedback: AudioFeedback) {
        self.inputFeedback = inputFeedback
        self.deleteFeedback = deleteFeedback
        self.systemFeedback = systemFeedback
    }
 
    public let inputFeedback: AudioFeedback
    public let deleteFeedback: AudioFeedback
    public let systemFeedback: AudioFeedback
    
    /**
     This configuration disables all haptic feedback.
     */
    public static var noFeedback: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration(
            inputFeedback: .none,
            deleteFeedback: .none,
            systemFeedback: .none
        )
    }
    
    /**
     This configuration uses standard haptic feedbacks, that
     are defined in the library.
    */
    public static var standard: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration(
            inputFeedback: .input,
            deleteFeedback: .delete,
            systemFeedback: .system
        )
    }
}
