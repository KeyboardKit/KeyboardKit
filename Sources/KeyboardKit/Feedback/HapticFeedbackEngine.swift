//
//  HapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to prepare and trigger haptic feedback.
 */
public protocol HapticFeedbackEngine {
    
    /**
     Prepare a certain haptic feedback type.
     */
    func prepare(_ feedback: HapticFeedback)

    /**
     Trigger a certain haptic feedback type.
     */
    func trigger(_ feedback: HapticFeedback)
}
