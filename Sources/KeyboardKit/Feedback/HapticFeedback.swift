//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains haptic feedback types that maps to names
 that are then mapped to system haptic feedback types.
  
 You can call ``trigger()`` on any feedback type, to trigger
 it with the ``HapticFeedback/Engine/shared`` haptic engine.
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
    
    /// The unique feedback identifier.
    var id: String { rawValue }

    /// Prepare the feedback with the shared feedback engine.
    func prepare() {
        HapticFeedback.Engine.shared.prepare(self)
    }
    
    /// Trigger the feedback with the shared feedback engine.
    func trigger() {
        HapticFeedback.Engine.shared.trigger(self)
    }
}
