//
//  HapticFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct specifies haptic feedback for a custom keyboard.
 */
public struct HapticFeedbackConfiguration: Codable, Equatable {
    
    /**
     Create a feedback configuration.
     
     - Parameters:
       - tap: The feedback to use for taps, by default `.none`.
       - doubleTap: The feedback to use for double taps, by default `.none`.
       - longPress: The feedback to use for long presses, by default `.none`.
       - longPressOnSpace: The feedback to use for long presses on space, by default `.mediumImpact`.
       - repeat: The feedback to use for repeat, by default `.none`.
       - actions: A list of action/gesture-specific feedback, by default `empty`.
     */
    public init(
        tap: HapticFeedback = .none,
        doubleTap: HapticFeedback = .none,
        longPress: HapticFeedback = .none,
        longPressOnSpace: HapticFeedback = .mediumImpact,
        repeat: HapticFeedback = .none,
        actions: [ActionFeedback] = []
    ) {
        self.tap = tap
        self.doubleTap = doubleTap
        self.longPress = longPress
        self.longPressOnSpace = longPressOnSpace
        self.repeat = `repeat`
        self.actions = actions
    }
    
    /**
     This struct is used for action-specific audio feedback.
     */
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
 
    /**
     The feedback to use for taps.
     */
    public var tap: HapticFeedback
    
    /**
     The feedback to use for double taps.
     */
    public var doubleTap: HapticFeedback
    
    /**
     The feedback to use for long presses.
     */
    public var longPress: HapticFeedback
    
    /**
     The feedback to use for long presses on space.
     */
    public var longPressOnSpace: HapticFeedback
    
    /**
     The feedback to use for repeat.
     */
    public var `repeat`: HapticFeedback
    
    /**
     A list of action/gesture-specific feedback.
     */
    public var actions: [ActionFeedback]
}

public extension HapticFeedbackConfiguration {
    
    /**
     This specifies an enabled haptic feedback configuration,
     where all feedback types generate some kind of feedback.
    */
    static let enabled = HapticFeedbackConfiguration(
        tap: .lightImpact,
        doubleTap: .lightImpact,
        longPress: .mediumImpact,
        longPressOnSpace: .mediumImpact,
        repeat: .selectionChanged)
    
    /**
     This configuration disables all haptic feedback.
     */
    static let noFeedback = HapticFeedbackConfiguration(
        tap: .none,
        doubleTap: .none,
        longPress: .none,
        longPressOnSpace: .none,
        repeat: .none
    )
    
    /**
     This specifies a standard haptic feedback configuration,
     where only `longPressOnSpace` triggers feedback.
    */
    static let standard = HapticFeedbackConfiguration()
}
