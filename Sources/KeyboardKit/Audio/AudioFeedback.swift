//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum provides audio feedback for keyboard actions. The
 feedback types can be triggered with the `trigger` function.
 
 The static `systemPlayer` uses a `StandardSystemAudioPlayer`
 by default, but you can change it to any `SystemAudioPlayer`
 you like, e.g. when writing tests.
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
     The global system audio player that is used to play the
     audio feedback.
     */
    static var systemPlayer: SystemAudioPlayer = StandardSystemAudioPlayer()
}


// MARK: - Public Functions

public extension AudioFeedback {
    
    func trigger() {
        AudioFeedback.trigger(self)
    }
    
    static func trigger(_ feedback: AudioFeedback) {
        guard let id = feedback.systemId else { return }
        systemPlayer.playSystemAudio(id)
    }
}
