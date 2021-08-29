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
  
 You can call `trigger()` on either the type or an instance,
 to trigger the desired feedback.
 
 The feedback enum uses the static `player` to play feedback.
 You can replace this instance with a custom player, e.g. to
 mock functionality when writing tests.
 
 `TODO` Make this `Codable` (which requires Xcode 13) in 5.0.
*/
public enum AudioFeedback: Equatable {
    
    case
    input,
    system,
    delete,
    custom(id: UInt32),
    none
    
    /**
     The system sound ID that corresponds to the feedback.
     */
    public var systemId: UInt32? {
        switch self {
        case .input: return 1104
        case .delete: return 1155
        case .system: return 1156
        case .custom(let value): return value
        case .none: return nil
        }
    }
    
    /**
     The standard player that is used for audio feedback.
     */
    public static var player: SystemAudioPlayer = StandardSystemAudioPlayer()
}


// MARK: - Public Functions

public extension AudioFeedback {
    
    func trigger() {
        AudioFeedback.trigger(self)
    }
    
    static func trigger(_ feedback: AudioFeedback) {
        guard let id = feedback.systemId else { return }
        player.playSystemAudio(id)
    }
}
