//
//  Feedback+AudioConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Feedback {
    
    /// This struct can be used to configure audio feedback.
    ///
    /// You can use any of the standard configurations, like
    /// ``enabled`` and ``disabled``, or create a custom one.
    struct AudioConfiguration: Codable, Equatable {
        
        /// Create a custom audio feedback configuration.
        ///
        /// - Parameters:
        ///   - input: The feedback to use for input keys, by default `.input`.
        ///   - delete: The feedback to use for delete keys, by default `.delete`.
        ///   - system: The feedback to use for system keys, by default `.system`.
        ///   - actions: A list of action-specific feedback, by default `empty`.
        public init(
            input: Feedback.Audio = .input,
            delete: Feedback.Audio = .delete,
            system: Feedback.Audio = .system,
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
                gesture: Gestures.KeyboardGesture,
                feedback: Feedback.Audio
            ) {
                self.action = action
                self.gesture = gesture
                self.feedback = feedback
            }
            
            public let action: KeyboardAction
            public let gesture: Gestures.KeyboardGesture
            public let feedback: Feedback.Audio
        }
        
        /// The audio to play when a delete key is pressed.
        public var delete: Feedback.Audio
        
        /// The audio to play when an input key is pressed.
        public var input: Feedback.Audio
        
        /// The audio to play when a system key is pressed.
        public var system: Feedback.Audio
        
        /// The audio to play when an action is triggered.
        public var actions: [ActionFeedback]
    }
}

public extension Feedback.AudioConfiguration {
    
    /// Get the feedback to use for a certain action.
    func feedback(
        for gesture: Gestures.KeyboardGesture = .press,
        on action: KeyboardAction
    ) -> ActionFeedback? {
        actions.first { $0.action == action && $0.gesture == gesture }
    }
    
    /// Register feedback for a certain action gesture.
    mutating func register(
        feedback: Feedback.Audio,
        for gesture: Gestures.KeyboardGesture = .press,
        on action: KeyboardAction
    ) {
        actions.append(
            .init(
                action: action,
                gesture: gesture,
                feedback: feedback
            )
        )
    }
}

public extension Feedback.AudioConfiguration {
    
    /// This configuration enables all audio feedback.
    static let enabled = Self()
    
    /// This configuration disables all audio feedback.
    static let disabled = Self(
        input: .none,
        delete: .none,
        system: .none
    )
}
