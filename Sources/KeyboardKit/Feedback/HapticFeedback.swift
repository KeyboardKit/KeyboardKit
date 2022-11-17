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
  
 You can call ``trigger()`` on any feedback value to trigger
 the desired feedback, using the ``player``. You can replace
 this player with any custom player if you need to.

 Note that `macOS`, `tvOS` and `watchOS` resolves a disabled
 ``HapticFeedbackPlayer`` by default, since the platforms do
 not support haptic feedback. Feel free to replace it with a
 player that does something meaningful on each platform.
*/
public enum HapticFeedback: String, CaseIterable, Codable, Equatable, Identifiable {
    
    case

    /// Represents feedback for an error event.
    error,

    /// Represents feedback for a successful event.
    success,

    /// Represents feedback for a warning event.
    warning,


    /// Represents light impact feedback.
    lightImpact,

    /// Represents medium impact feedback.
    mediumImpact,

    /// Represents heavy impact feedback.
    heavyImpact,


    /// Represents feedback when a selection changes.
    selectionChanged,


    /// Can be used to disable feedback.
    none
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    /**
     The unique feedback identifier.
     */
    var id: String { rawValue }

    /**
     The player that will be used to trigger haptic feedback.
     */
    static var player: HapticFeedbackPlayer = {
        #if os(iOS)
        StandardHapticFeedbackPlayer.shared
        #else
        DisabledHapticFeedbackPlayer()
        #endif
    }()
    
    /**
     Prepare the haptic feedback, using the shared player.
     */
    func prepare() {
        Self.player.prepare(self)
    }
    
    /**
     Trigger the feedback, using the shared player.
     */
    func trigger() {
        Self.player.play(self)
    }
}
