//
//  HapticFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to prepare and play haptic feedback.
 */
public protocol HapticFeedbackPlayer {
    
    /**
     Play a certain haptic feedback type.
     */
    func play(_ feedback: HapticFeedback)
    
    /**
     Prepare a certain haptic feedback type for being played.
     */
    func prepare(_ feedback: HapticFeedback)
}
