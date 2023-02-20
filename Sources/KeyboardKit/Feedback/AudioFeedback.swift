//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains various audio feedback types.
  
 You can call ``trigger()`` on any feedback value to trigger
 it, using the static ``engine``. You can replace the engine
 with any custom engine if you need to.

 Note that `watchOS` creates a ``DisabledAudioFeedbackEngine``
 by default, since the platform doesn't support system audio.
 You can replace it with another engine, that does something
 meaningful on that platform.
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
    
    /**
     The unique feedback identifier.

     This identifier maps to a unique system sound, which is
     used by the ``StandardAudioFeedbackEngine``.
     */
    var id: UInt32 {
        switch self {
        case .input: return 1104
        case .delete: return 1155
        case .system: return 1156
        case .custom(let value): return value
        case .none: return 0
        }
    }

    /**
     The engine that will be used to trigger audio feedback.
     */
    static var engine: AudioFeedbackEngine = {
        #if os(iOS) || os(macOS) || os(tvOS)
        StandardAudioFeedbackEngine.shared
        #else
        DisabledAudioFeedbackEngine()
        #endif
    }()
    
    /**
     Trigger the feedback, using the shared feedback engine.
     */
    func trigger() {
        Self.engine.trigger(self)
    }
}
