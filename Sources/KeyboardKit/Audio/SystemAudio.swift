//
//  SystemAudio.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains various system audio types.
  
 You can call `trigger()` on either the type or an instance,
 to trigger the desired feedback.
 
 The feedback enum uses the static `player` to play feedback.
 You can replace this instance with a custom player, e.g. to
 mock functionality when writing tests.
*/
public enum SystemAudio: Codable, Equatable, Identifiable {
    
    case
    input,
    system,
    delete,
    custom(id: UInt32),
    none
    
    /**
     The system sound ID that corresponds to the feedback.
     */
    public var id: UInt32 {
        switch self {
        case .input: return 1104
        case .delete: return 1155
        case .system: return 1156
        case .custom(let value): return value
        case .none: return 0
        }
    }
}


// MARK: - Public Functions

public extension SystemAudio {
    
    func trigger() {
        SystemAudio.trigger(self)
    }
    
    static func trigger(_ audio: SystemAudio) {
        StandardSystemAudioPlayer.shared.playSystemAudio(audio)
    }
}
