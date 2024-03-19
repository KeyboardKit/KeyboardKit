//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum defines standard haptic feedback types.
///
/// You can call ``trigger()`` on any feedback type, to play
/// it with the ``HapticFeedback/Engine/shared`` engine.
/// 
/// Each feedback type has a native haptic type that will be
/// played when feedback is triggered.
public enum HapticFeedback: String, CaseIterable, Codable, Equatable, Identifiable {
    
    /// Represents feedback for an error event.
    case error

    /// Represents feedback for a successful event.
    case success

    /// Represents feedback for a warning event.
    case warning


    /// Represents light impact feedback.
    case lightImpact

    /// Represents medium impact feedback.
    case mediumImpact

    /// Represents heavy impact feedback.
    case heavyImpact


    /// Represents feedback when a selection changes.
    case selectionChanged


    /// Can be used to disable feedback.
    case none
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
