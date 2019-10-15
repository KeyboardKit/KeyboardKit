//
//  AudioFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum provides audio feedback for keyboard actions. The
 enum cases can be triggered right away, using `AudioToolbox`.
 
 The system audioplayer can be replaced by switching out the
 `systemPlayer` with another player. This is useful when you
 want to unit test the class or change its behavior.
 
 `TODO:` The system sound shouldn't use the same ID as input,
 but I could not find the correct audio.
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
        case .system: return 1104
        case .delete: return 1155
        case .custom(let value): return value
        case .none: return nil
        }
    }
    
    /**
     The global system audio player that is used to play the
     audio feedback.
     */
    public static var systemPlayer: SystemAudioPlayer = StandardSystemAudioPlayer()
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
