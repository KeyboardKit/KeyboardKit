//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This disabled player doesn't do anything and can be used on
 platforms where haptic feedback is not available.
 */
public class DisabledHapticFeedbackPlayer: HapticFeedbackPlayer {
    
    /**
     Create a disabled player.
     */
    public init() {}

    public func play(_ feedback: HapticFeedback) {}
    public func prepare(_ feedback: HapticFeedback) {}
}
