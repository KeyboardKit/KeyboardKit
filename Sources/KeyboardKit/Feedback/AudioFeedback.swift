//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains various audio feedback types.
  
 You can call ``play()`` on any value to trigger the desired
 feedback, using the static ``player``. You can replace this
 player with any custom player if you need to.

 Note that `watchOS` creates a ``DisabledAudioFeedbackPlayer``
 by default, since the platform doesn't support system audio.
 You can replace it with another player, that does something
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
     used by the ``StandardAudioFeedbackPlayer``.
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
     The player that will be used to trigger audio feedback.
     */
    static var player: AudioFeedbackPlayer = {
        #if os(iOS) || os(macOS) || os(tvOS)
        StandardAudioFeedbackPlayer.shared
        #else
        DisabledAudioFeedbackPlayer()
        #endif
    }()
    
    /**
     Trigger the feedback, using the shared player.
     */
    func trigger() {
        Self.player.play(self)
    }
}
