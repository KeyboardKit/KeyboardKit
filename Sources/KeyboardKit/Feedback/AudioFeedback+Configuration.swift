//
//  AudioFeedback+Configuration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AudioFeedback {
    
    /**
     This struct can be used to configure audio feedback.
     
     You can create a custom configuration or use the static
     values, like ``AudioFeedback/Configuration/enabled``.
     */
    struct Configuration: Codable, Equatable {
        
        /**
         Create an audio feedback configuration.
         
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
        
        /// This struct is used for action-specific feedback.
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
        
        /// The audio to play when a delete key is pressed.
        public var delete: AudioFeedback
        
        /// The audio to play when an input key is pressed.
        public var input: AudioFeedback
        
        /// The audio to play when a system key is pressed.
        public var system: AudioFeedback
        
        /// The audio to play when an action is triggered.
        public var actions: [ActionFeedback]
    }
}

public extension AudioFeedback.Configuration {
    
    /// This configuration enables all audio feedback.
    static let enabled = Self()
    
    /// This configuration disables all audio feedback.
    static let disabled = Self(
        input: .none,
        delete: .none,
        system: .none
    )
}
