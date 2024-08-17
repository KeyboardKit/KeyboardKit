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
        ///   - custom: A list of custom feedback, by default `empty`.
        public init(
            input: Feedback.Audio = .input,
            delete: Feedback.Audio = .delete,
            system: Feedback.Audio = .system,
            custom: [CustomFeedback] = []
        ) {
            self.input = input
            self.delete = delete
            self.system = system
            self.custom = custom
        }
        
        /// The audio to play when a delete key is pressed.
        public var delete: Feedback.Audio
        
        /// The audio to play when an input key is pressed.
        public var input: Feedback.Audio
        
        /// The audio to play when a system key is pressed.
        public var system: Feedback.Audio
        
        /// A list of custom audio feedback.
        public var custom: [CustomFeedback]
    }
}

public extension Feedback.AudioConfiguration {
    
    /// This struct is used for custom audio feedback.
    struct CustomFeedback: Codable, Equatable {
        
        public init(
            action: KeyboardAction,
            gesture: Keyboard.Gesture,
            feedback: Feedback.Audio
        ) {
            self.action = action
            self.gesture = gesture
            self.feedback = feedback
        }
        
        public let action: KeyboardAction
        public let gesture: Keyboard.Gesture
        public let feedback: Feedback.Audio
    }
}

public extension Feedback.AudioConfiguration.CustomFeedback {
    
    /// Create a custom audio feedback configuration.
    static func audio(
        _ feedback: Feedback.Audio,
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Self {
        .init(action: action, gesture: gesture, feedback: feedback)
    }
}

public extension Feedback.AudioConfiguration {
    
    /// Get a custom registered feedback, if any.
    func customFeedback(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Feedback.Audio? {
        custom.first {
            $0.action == action && $0.gesture == gesture
        }?.feedback
    }
    
    /// Whether a custom feedback has been registered.
    func hasCustomFeedback(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool {
        customFeedback(for: gesture, on: action) != nil
    }
    
    /// Get the feedback to use for a certain action.
    func feedback(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Feedback.Audio? {
        customFeedback(for: gesture, on: action)
    }
    
    /// Register feedback for a certain action gesture.
    mutating func registerCustomFeedback(
        _ feedback: CustomFeedback
    ) {
        custom.append(feedback)
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
