//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This haptic feedback player does not do anything and can be
 used on platforms where haptic feedback is not available.
 
 You can use the ``
 */
public class DisabledHapticFeedbackPlayer: HapticFeedbackPlayer {
    
    /**
     Create a disabled player.
     */
    public init() {}
    
    /**
     Play a certain haptic feedback type.
     */
    public func play(_ feedback: HapticFeedback) {}
    
    /**
     Prepare a certain haptic feedback type for being played.
     */
    public func prepare(_ feedback: HapticFeedback) {}
}

public extension DisabledHapticFeedbackPlayer {
    
    /**
     This shared instance is used on some platforms.
     */
    static var shared = DisabledHapticFeedbackPlayer()
}
