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
 
 `TODO` Make this `Codable` (which requires Xcode 13) in 5.0.
 */
public struct AudioFeedbackConfiguration: Equatable {
    
    public init(
        inputFeedback: SystemAudio = .input,
        deleteFeedback: SystemAudio = .delete,
        systemFeedback: SystemAudio = .system) {
        self.inputFeedback = inputFeedback
        self.deleteFeedback = deleteFeedback
        self.systemFeedback = systemFeedback
    }
 
    public let inputFeedback: SystemAudio
    public let deleteFeedback: SystemAudio
    public let systemFeedback: SystemAudio
    
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
