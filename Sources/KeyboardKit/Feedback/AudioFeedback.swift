//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum defines standard audio feedback types.
///
/// You can call ``trigger()`` on any feedback type, to play
/// it with the ``AudioFeedback/Engine/shared`` engine.
///
/// Each feedback type has a unique system id that refers to
/// a system sound that is played when feedback is triggered.
public enum AudioFeedback: Codable, Equatable, Identifiable {
    
    /// Represents the sound of an input key.
    case input
    
    /// Represents the sound of a system key.
    case system
    
    /// Represents the sound of a delete key.
    case delete
    
    /// Represents a custom system sound.
    case custom(id: UInt32)
    
    /// Can be used to disable feedback.
    case none
}

public extension AudioFeedback {
    
    /// The unique system sound identifier.
    var id: UInt32 {
        switch self {
        case .input: 1104
        case .delete: 1155
        case .system: 1156
        case .custom(let value): value
        case .none: 0
        }
    }
    
    /// Trigger the feedback with the shared feedback engine.
    func trigger() {
        AudioFeedback.Engine.shared.trigger(self)
    }
}
