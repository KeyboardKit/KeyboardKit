//
//  KeyboardFeedback+AudioConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardFeedback {

    /// This struct can be used to configure audio feedback.
    ///
    /// You can use any of the standard configurations, like
    /// ``enabled`` and ``disabled``, or create a custom one.
    struct AudioConfiguration: KeyboardModel {
        
        /// Create a custom audio feedback configuration.
        ///
        /// - Parameters:
        ///   - input: The feedback to use for input keys, by default `.input`.
        ///   - delete: The feedback to use for delete keys, by default `.delete`.
        ///   - system: The feedback to use for system keys, by default `.system`.
        ///   - custom: A list of custom feedback, by default `empty`.
        public init(
            input: Audio = .input,
            delete: Audio = .delete,
            system: Audio = .system,
            custom: [CustomFeedback] = []
        ) {
            self.input = input
            self.delete = delete
            self.system = system
            self.custom = custom
        }
        
        /// The audio to play when a delete key is pressed.
        public var delete: Audio
        
        /// The audio to play when an input key is pressed.
        public var input: Audio
        
        /// The audio to play when a system key is pressed.
        public var system: Audio
        
        /// A list of custom audio feedback.
        public var custom: [CustomFeedback]
    }
}

public extension KeyboardFeedback.AudioConfiguration {

    /// This struct is used for custom audio feedback.
    struct CustomFeedback: KeyboardModel {
        
        public init(
            action: KeyboardAction,
            gesture: Keyboard.Gesture,
            feedback: KeyboardFeedback.Audio
        ) {
            self.action = action
            self.gesture = gesture
            self.feedback = feedback
        }
        
        public let action: KeyboardAction
        public let gesture: Keyboard.Gesture
        public let feedback: KeyboardFeedback.Audio
    }
}

public extension KeyboardFeedback.AudioConfiguration {

    /// A standard, enabled audio configuration.
    static let standard = Self()

    /// This configuration disables all audio feedback.
    static let disabled = Self(
        input: .none,
        delete: .none,
        system: .none
    )
}

public extension KeyboardFeedback.AudioConfiguration.CustomFeedback {

    /// Create a custom audio feedback configuration.
    static func audio(
        _ feedback: KeyboardFeedback.Audio,
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Self {
        .init(action: action, gesture: gesture, feedback: feedback)
    }
}

public extension KeyboardFeedback.AudioConfiguration {

    /// Get a custom registered feedback, if any.
    func customFeedback(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> KeyboardFeedback.Audio? {
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
    ) -> KeyboardFeedback.Audio? {
        customFeedback(for: gesture, on: action)
    }
    
    /// Register feedback for a certain action gesture.
    mutating func registerCustomFeedback(
        _ feedback: CustomFeedback
    ) {
        custom.append(feedback)
    }
}
