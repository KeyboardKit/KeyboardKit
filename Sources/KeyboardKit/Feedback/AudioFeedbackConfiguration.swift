//
//  AudioFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct specifies audio feedback for a custom keyboard.
 */
public struct AudioFeedbackConfiguration: Codable, Equatable {
    
    /**
     Create a feedback configuration.
     
     - Parameters:
       - input: The feedback to use for input keys, by default `.input`.
       - delete: The feedback to use for delete keys, by default `.delete`.
       - system: The feedback to use for system keys, by default `.system`.
       - actions: A list of action-specific feedback, by default `empty`.
     */
    public init(
        input: AudioFeedback = .input,
        delete: AudioFeedback = .delete,
        system: AudioFeedback = .system,
        actions: [ActionFeedback] = []
    ) {
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
            feedback: AudioFeedback
        ) {
            self.action = action
            self.feedback = feedback
        }
        
        public let action: KeyboardAction
        public let feedback: AudioFeedback
    }
    
    /**
     The audio to trigger when a delete key is pressed.
     */
     public var delete: AudioFeedback
 
    /**
     The audio to trigger when an input key is pressed.
     */
    public var input: AudioFeedback
    
   /**
    The audio to trigger when a system key is pressed.
    */
    public var system: AudioFeedback
    
    /**
     The audio to trigger when an action is triggered.
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
