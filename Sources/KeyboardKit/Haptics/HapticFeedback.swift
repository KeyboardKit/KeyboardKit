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
public enum HapticFeedback: String, CaseIterable, Codable, Equatable, Identifiable {
    
    case
    error,
    success,
    warning,
    
    lightImpact,
    mediumImpact,
    heavyImpact,
    
    selectionChanged,
    
    none
    
    public var id: String { rawValue }
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    /**
     Prepare the haptic feedback, using the shared player.
     */
    func prepare() {
        StandardHapticFeedbackPlayer.shared.prepare(self)
    }
    
    /**
     Trigger the haptic feedback, using the shared player.
     */
    func trigger() {
        StandardHapticFeedbackPlayer.shared.play(self)
    }
}
