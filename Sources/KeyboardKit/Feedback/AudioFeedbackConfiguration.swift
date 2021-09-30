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
    
    /**
     Create a feedback configuration.
     
     - Parameters:
       - input: The feedback to use for input keys.
       - delete: The feedback to use for delete keys.
       - system: The feedback to use for system keys.
     */
    public init(
        input: SystemAudio = .input,
        delete: SystemAudio = .delete,
        system: SystemAudio = .system) {
        self.input = input
        self.delete = delete
        self.system = system
    }
    
    /**
     The audio to play when a delete key is pressed.
     */
     public let delete: SystemAudio
 
    /**
     The audio to play when an input key is pressed.
     */
    public let input: SystemAudio
    
   /**
    The audio to play when a system key is pressed.
    */
    public let system: SystemAudio
}

public extension AudioFeedbackConfiguration {
    
    /**
     This configuration disables all audio feedback.
     */
    static var noFeedback: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration(
            input: .none,
            delete: .none,
            system: .none
        )
    }
    
    /**
     This configuration uses standard audio feedbacks, which
     tries to replicate the standard system behavior.
    */
    static var standard: AudioFeedbackConfiguration {
        AudioFeedbackConfiguration()
    }
}
