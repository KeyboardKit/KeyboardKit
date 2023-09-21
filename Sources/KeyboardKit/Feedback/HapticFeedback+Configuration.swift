//
//  HapticFeedback+Configuration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension HapticFeedback {
    
    /**
     This struct can be used to configure haptic feedback.
     
     You can create a custom configuration or use the predefined,
     static values like ``HapticFeedbackConfiguration/enabled``.
     */
    struct Configuration: Codable, Equatable {
        
        /**
         Create a haptic feedback configuration.
         
         - Parameters:
           - press: The feedback to use for presses, by default `.none`.
           - release: The feedback to use for releases, by default `.none`.
           - doubleTap: The feedback to use for double taps, by default `.none`.
           - longPress: The feedback to use for long presses, by default `.none`.
           - longPressOnSpace: The feedback to use for long presses on space, by default `.mediumImpact`.
           - repeat: The feedback to use for repeat, by default `.none`.
           - actions: A list of action/gesture-specific feedback, by default `empty`.
         */
        public init(
            press: HapticFeedback = .none,
            release: HapticFeedback = .none,
            doubleTap: HapticFeedback = .none,
            longPress: HapticFeedback = .none,
            longPressOnSpace: HapticFeedback = .mediumImpact,
            repeat: HapticFeedback = .none,
            actions: [ActionFeedback] = []
        ) {
            self.press = press
            self.release = release
            self.doubleTap = doubleTap
            self.longPress = longPress
            self.longPressOnSpace = longPressOnSpace
            self.repeat = `repeat`
            self.actions = actions
        }
        
        /// This struct is used for action-specific feedback.
        public struct ActionFeedback: Codable, Equatable {
            
            public init(
                action: KeyboardAction,
                gesture: KeyboardGesture,
                feedback: HapticFeedback
            ) {
                self.action = action
                self.gesture = gesture
                self.feedback = feedback
            }
            
            public let action: KeyboardAction
            public let gesture: KeyboardGesture
            public let feedback: HapticFeedback
        }
        
        /// The feedback to use for presses.
        public var press: HapticFeedback
        
        /// The feedback to use for releases.
        public var release: HapticFeedback
        
        /// The feedback to use for double taps.
        public var doubleTap: HapticFeedback
        
        /// The feedback to use for long presses.
        public var longPress: HapticFeedback
        
        /// The feedback to use for long presses on space.
        public var longPressOnSpace: HapticFeedback
        
        /// The feedback to use for repeat.
        public var `repeat`: HapticFeedback
        
        /// A list of action/gesture-specific feedback.
        public var actions: [ActionFeedback]
    }
}

public extension HapticFeedback.Configuration {
    
    /// This configuration enables all audio feedback.
    static let enabled = HapticFeedback.Configuration(
        press: .lightImpact,
        release: .lightImpact,
        doubleTap: .lightImpact,
        longPress: .mediumImpact,
        longPressOnSpace: .mediumImpact,
        repeat: .selectionChanged
    )
    
    /// This configuration disables all audio feedback.
    static let disabled = HapticFeedback.Configuration(
        press: .none,
        release: .none,
        doubleTap: .none,
        longPress: .none,
        longPressOnSpace: .none,
        repeat: .none
    )
    
    /// This configuration only enables long press on space.
    static let minimal = HapticFeedback.Configuration(
        press: .none,
        release: .none,
        doubleTap: .none,
        longPress: .none,
        longPressOnSpace: .mediumImpact,
        repeat: .none
    )
}
