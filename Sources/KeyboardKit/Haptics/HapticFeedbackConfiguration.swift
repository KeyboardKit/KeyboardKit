//
//  HapticFeedbackConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This configuration struct specifies a haptic feedback setup
 for custom keyboards.
 */
public struct HapticFeedbackConfiguration {
    
    public init(
        tapFeedback: HapticFeedback,
        doubleTapFeedback: HapticFeedback = .standardDoubleTapFeedback,
        longPressFeedback: HapticFeedback,
        repeatFeedback: HapticFeedback) {
        self.tapFeedback = tapFeedback
        self.doubleTapFeedback = doubleTapFeedback
        self.longPressFeedback = longPressFeedback
        self.repeatFeedback = repeatFeedback
    }
 
    public let tapFeedback: HapticFeedback
    public let doubleTapFeedback: HapticFeedback
    public let longPressFeedback: HapticFeedback
    public let repeatFeedback: HapticFeedback
    
    /**
     This configuration disables all haptic feedback.
     */
    public static var noFeedback: HapticFeedbackConfiguration {
        HapticFeedbackConfiguration(
            tapFeedback: .none,
            doubleTapFeedback: .none,
            longPressFeedback: .none,
            repeatFeedback: .none
        )
    }
    
    /**
     This configuration uses standard haptic feedbacks, that
     are defined in the library.
    */
    public static var standard: HapticFeedbackConfiguration {
        HapticFeedbackConfiguration(
            tapFeedback: .standardTapFeedback,
            doubleTapFeedback: .standardDoubleTapFeedback,
            longPressFeedback: .standardLongPressFeedback,
            repeatFeedback: .none
        )
    }
}
