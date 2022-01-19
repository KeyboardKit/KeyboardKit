//
//  StandardSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox

/**
 This player uses system features to play system audio. It's
 the default ``SystemAudio`` player on platforms where it is
 supported.

 You can use, modify and replace the ``shared`` player. This
 lets you customize the global audio feedback experience.
 
 Note that the player is currently only supported on certain
 platforms.
 */
open class StandardSystemAudioPlayer: SystemAudioPlayer {
    
    public init() {}
    
    /**
     Play a certain system audio sound.
     **/
    open func play(_ audio: SystemAudio) {
        switch audio {
        case .none: return
        default: AudioServicesPlaySystemSound(audio.id)
        }
    }
}

public extension StandardSystemAudioPlayer {
    
    /**
     The standard player that is used for audio feedback.
     */
    static var shared = StandardSystemAudioPlayer()
}
#endif
