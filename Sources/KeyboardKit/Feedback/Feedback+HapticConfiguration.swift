//
//  Feedback+HapticConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Feedback {
    
    /// This struct can be used to configure haptic feedback.
    ///
    /// You can use any of the standard configurations, like
    /// ``enabled`` and ``disabled``, or create a custom one.
    ///
    /// Note that this library uses ``minimal`` as a default
    /// configuration.
    struct HapticConfiguration: Codable, Equatable {
        
        /// Create a custom haptic feedback configuration.
        ///
        /// - Parameters:
        ///   - press: The feedback to use for presses, by default `.none`.
        ///   - release: The feedback to use for releases, by default `.none`.
        ///   - doubleTap: The feedback to use for double taps, by default `.none`.
        ///   - longPress: The feedback to use for long presses, by default `.none`.
        ///   - longPressOnSpace: The feedback to use for long presses on space, by default `.mediumImpact`.
        ///   - repeat: The feedback to use for repeat, by default `.none`.
        ///   - custom: A list of custom feedback, by default `empty`.
        public init(
            press: Feedback.Haptic = .none,
            release: Feedback.Haptic = .none,
            doubleTap: Feedback.Haptic = .none,
            longPress: Feedback.Haptic = .none,
            longPressOnSpace: Feedback.Haptic = .mediumImpact,
            repeat: Feedback.Haptic = .none,
            custom: [CustomFeedback] = []
        ) {
            self.press = press
            self.release = release
            self.doubleTap = doubleTap
            self.longPress = longPress
            self.longPressOnSpace = longPressOnSpace
            self.repeat = `repeat`
            self.custom = custom + [
                .haptic(longPressOnSpace, for: .longPress, on: .space)
            ]
        }
        
        /// The feedback to use for presses.
        public var press: Feedback.Haptic
        
        /// The feedback to use for releases.
        public var release: Feedback.Haptic
        
        /// The feedback to use for double taps.
        public var doubleTap: Feedback.Haptic
        
        /// The feedback to use for long presses.
        public var longPress: Feedback.Haptic
        
        /// The feedback to use for long presses on space.
        public var longPressOnSpace: Feedback.Haptic
        
        /// The feedback to use for repeat.
        public var `repeat`: Feedback.Haptic
        
        /// A list of custom haptic feedback.
        public var custom: [CustomFeedback]
    }
}

public extension Feedback.HapticConfiguration {
    
    /// This struct is used for custom haptic feedback.
    struct CustomFeedback: Codable, Equatable {
        
        public init(
            action: KeyboardAction,
            gesture: Gestures.KeyboardGesture,
            feedback: Feedback.Haptic
        ) {
            self.action = action
            self.gesture = gesture
            self.feedback = feedback
        }
        
        public let action: KeyboardAction
        public let gesture: Gestures.KeyboardGesture
        public let feedback: Feedback.Haptic
    }
}

public extension Feedback.HapticConfiguration.CustomFeedback {
    
    /// Create a custom haptic feedback configuration.
    static func haptic(
        _ feedback: Feedback.Haptic,
        for gesture: Gestures.KeyboardGesture,
        on action: KeyboardAction
    ) -> Self {
        .init(action: action, gesture: gesture, feedback: feedback)
    }
}

public extension Feedback.HapticConfiguration {
    
    /// Get a custom registered feedback, if any.
    func customFeedback(
        for gesture: Gestures.KeyboardGesture,
        on action: KeyboardAction
    ) -> Feedback.Haptic? {
        custom.first {
            $0.action == action && $0.gesture == gesture
        }?.feedback
    }
    
    /// Whether a custom feedback has been registered.
    func hasCustomFeedback(
        for gesture: Gestures.KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        customFeedback(for: gesture, on: action) != nil
    }
    
    /// Get the feedback to use for a certain action.
    func feedback(
        for gesture: Gestures.KeyboardGesture,
        on action: KeyboardAction
    ) -> Feedback.Haptic? {
        let custom = customFeedback(for: gesture, on: action)
        return custom ?? feedback(for: gesture)
    }
    
    /// Register feedback for a certain action gesture.
    mutating func registerCustomFeedback(
        _ feedback: CustomFeedback
    ) {
        custom.append(feedback)
    }
}

public extension Feedback.HapticConfiguration {
    
    /// This configuration enables all audio feedback.
    static let enabled = Self(
        press: .lightImpact,
        release: .lightImpact,
        doubleTap: .lightImpact,
        longPress: .mediumImpact,
        longPressOnSpace: .mediumImpact,
        repeat: .selectionChanged
    )
    
    /// This configuration disables all audio feedback.
    static let disabled = Self(
        press: .none,
        release: .none,
        doubleTap: .none,
        longPress: .none,
        longPressOnSpace: .none,
        repeat: .none
    )
    
    /// This configuration only enables long press on space.
    static let minimal = Self(
        press: .none,
        release: .none,
        doubleTap: .none,
        longPress: .none,
        longPressOnSpace: .mediumImpact,
        repeat: .none
    )
}

private extension Feedback.HapticConfiguration {
    
    /// Get the feedback to use for a certain gesture.
    func feedback(
        for gesture: Gestures.KeyboardGesture
    ) -> Feedback.Haptic? {
        switch gesture {
        case .doubleTap: doubleTap
        case .longPress: longPress
        case .press: press
        case .release: release
        case .repeatPress: `repeat`
        case .end: nil
        }
    }
}
