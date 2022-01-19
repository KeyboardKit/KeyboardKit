//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains various haptic feedback types.
  
 You can call `prepare()` and `trigger()` on either the type
 or an instance, to prepare and trigger the desired feedback.
 
 The feedback enum uses the static `player` to play feedback.
 You can replace this instance with a custom player, e.g. to
 mock functionality when writing tests.
 
 Note that this enum is available on tvOS, where there is no
 haptic feedback. However,
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
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    /**
     The feedback's unique identifier.
     */
    var id: String { rawValue }
    
    #if os(iOS) || os(macOS)
    static var player = StandardHapticFeedbackPlayer.shared
    #else
    static var player = DisabledHapticFeedbackPlayer()
    #endif
    
    /**
     Prepare the haptic feedback, using the shared player.
     */
    func prepare() {
        Self.player.prepare(self)
    }
    
    /**
     Trigger the haptic feedback, using the shared player.
     */
    func trigger() {
        Self.player.play(self)
    }
}
