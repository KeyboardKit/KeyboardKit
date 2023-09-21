//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains audio feedback types that maps to system
 audio feedback values.
 
 Each feedback type has a unique system sound ``id`` that is
 used when the sound is played with ``AudioFeedback/Engine``.
 
 You can call ``trigger()`` on any feedback type, to play it
 with the ``AudioFeedback/Engine/shared`` audio engine.
*/
public enum AudioFeedback: Codable, Equatable, Identifiable {
    
    case
    
    /// Represents the sound of an input key.
    input,
    
    /// Represents the sound of a system key.
    system,
    
    /// Represents the sound of a delete key.
    delete,
    
    /// Represents a custom system sound.
    custom(id: UInt32),
    
    /// Can be used to disable feedback.
    none
}

public extension AudioFeedback {
    
    /// The unique feedback identifier.
    var id: UInt32 {
        switch self {
        case .input: return 1104
        case .delete: return 1155
        case .system: return 1156
        case .custom(let value): return value
        case .none: return 0
        }
    }
    
    /// Trigger the feedback with the shared feedback engine.
    func trigger() {
        AudioFeedback.Engine.shared.trigger(self)
    }
}
