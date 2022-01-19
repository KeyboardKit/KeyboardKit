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
    
    /// `.input` represents the sound of an input key.
    input,
    
    /// `.system` represents the sound of a system key.
    system,
    
    /// `.delete` represents the sound of a delete key.
    delete,
    
    /// `.custom` represents a custom sound.
    custom(id: UInt32),
    
    /// `.none` represents no sound.
    none
}

public extension SystemAudio {
    
    /**
     The system sound ID that corresponds to the feedback.
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
    
    #if os(iOS) || os(macOS) || os(tvOS)
    static var player = StandardSystemAudioPlayer.shared
    #else
    static var player = DisabledSystemAudioPlayer()
    #endif
    
    /**
     Play the system audio, using the shared audio player.
     */
    func play() {
        Self.player.play(self)
    }
}
