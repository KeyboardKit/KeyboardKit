//
//  AudioFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct specifies audio feedback for a custom keyboard.
 */
public struct AudioFeedbackConfiguration: Codable, Equatable {
    
    public init(
        inputFeedback: AudioFeedback = .input,
        deleteFeedback: AudioFeedback = .delete,
        systemFeedback: AudioFeedback = .system) {
        self.inputFeedback = inputFeedback
        self.deleteFeedback = deleteFeedback
        self.systemFeedback = systemFeedback
    }
 
    public let inputFeedback: AudioFeedback
    public let deleteFeedback: AudioFeedback
    public let systemFeedback: AudioFeedback
    
    /**
     This configuration disables all audio feedback.
     */
    public static var noFeedback: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration(
            inputFeedback: .none,
            deleteFeedback: .none,
            systemFeedback: .none
        )
    }
    
    /**
     This configuration uses standard audio feedbacks, which
     tries to replicate the standard system behavior.
    */
    public static var standard: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration()
    }
}
