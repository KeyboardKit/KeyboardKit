//
//  HapticFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct specifies haptic feedback for a custom keyboard.
 */
public struct HapticFeedbackConfiguration: Equatable {
    
    /**
     Create a feedback configuration.
     
     - Parameters:
       - tap: The feedback to use for taps.
       - doubleTap: The feedback to use for double taps.
       - longPress: The feedback to use for long presses.
       - longPressOnSpace: The feedback to use for long presses on space.
       - repeat: The feedback to use for repeat.
     */
    public init(
        tap: HapticFeedback = .none,
        doubleTap: HapticFeedback = .none,
        longPress: HapticFeedback = .none,
        longPressOnSpace: HapticFeedback = .mediumImpact,
        repeat: HapticFeedback = .none) {
        self.tap = tap
        self.doubleTap = doubleTap
        self.longPress = longPress
        self.longPressOnSpace = longPressOnSpace
        self.repeat = `repeat`
    }
 
    public let tap: HapticFeedback
    public let doubleTap: HapticFeedback
    public let longPress: HapticFeedback
    public let longPressOnSpace: HapticFeedback
    public let `repeat`: HapticFeedback
    
    /**
     This configuration disables all haptic feedback.
     */
    public static var noFeedback: HapticFeedbackConfiguration {
        HapticFeedbackConfiguration(
            tap: .none,
            doubleTap: .none,
            longPress: .none,
            longPressOnSpace: .none,
            repeat: .none
        )
    }
    
    /**
     This configuration specifies a standard haptic feedback.
    */
    public static var standard: HapticFeedbackConfiguration {
        HapticFeedbackConfiguration()
    }
}
