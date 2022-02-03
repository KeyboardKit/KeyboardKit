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
       - actions: A list of action-specific feedback.
     */
    public init(
        input: SystemAudio = .input,
        delete: SystemAudio = .delete,
        system: SystemAudio = .system,
        actions: [ActionFeedback] = []) {
        self.input = input
        self.delete = delete
        self.system = system
        self.actions = actions
    }
    
    /**
     This struct is used for action-specific audio feedback.
     */
    public struct ActionFeedback: Codable, Equatable {
        
        public init(
            action: KeyboardAction,
            feedback: SystemAudio) {
            self.action = action
            self.feedback = feedback
        }
        
        public let action: KeyboardAction
        public let feedback: SystemAudio
    }
    
    /**
     The audio to play when a delete key is pressed.
     */
     public var delete: SystemAudio
 
    /**
     The audio to play when an input key is pressed.
     */
    public var input: SystemAudio
    
   /**
    The audio to play when a system key is pressed.
    */
    public var system: SystemAudio
    
    /**
     The audio to play when an action is triggered.
     */
     public var actions: [ActionFeedback]
}

public extension AudioFeedbackConfiguration {
    
    /**
     This specifies an `enabled` audio feedback config where
     all feedback types generate some kind of feedback.
    */
    static let enabled: AudioFeedbackConfiguration = .standard
    
    /**
     This configuration disables all audio feedback.
     */
    static let noFeedback = AudioFeedbackConfiguration(
        input: .none,
        delete: .none,
        system: .none)
    
    /**
     This configuration uses standard audio feedbacks, which
     tries to replicate the standard system behavior.
    */
    static let standard = AudioFeedbackConfiguration()
}
