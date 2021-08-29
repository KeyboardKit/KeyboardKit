//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This enum contains various haptic feedback types.
  
 You can call `prepare()` and `trigger()` on either the type
 or an instance, to prepare and trigger the desired feedback.
 
 The feedback enum uses the static `player` to play feedback.
 You can replace this instance with a custom player, e.g. to
 mock functionality when writing tests.
*/
public enum HapticFeedback: CaseIterable, Codable, Equatable {
    
    case
    error,
    success,
    warning,
    
    lightImpact,
    mediumImpact,
    heavyImpact,
    
    selectionChanged,
    
    none
    
    /**
     The standard player that is used for haptic feedback.
     */
    public static var player: HapticFeedbackPlayer = StandardHapticFeedbackPlayer()
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    func prepare() {
        HapticFeedback.prepare(self)
    }
    
    static func prepare(_ feedback: HapticFeedback) {
        player.prepare(feedback)
    }
    
    func trigger() {
        HapticFeedback.trigger(self)
    }
    
    static func trigger(_ feedback: HapticFeedback) {
        player.play(feedback)
    }
}
