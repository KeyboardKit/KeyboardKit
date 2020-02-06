//
//  StandardSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//

import AudioToolbox

/**
 This class plays system audio with `AudioToolbox`. It's the
 standard system audio player and is used by `AudioFeedback`
 by default, if a custom player isn't provided.
 */
public class StandardSystemAudioPlayer: SystemAudioPlayer {
    
    public func playSystemAudio(_ id: UInt32) {
        AudioServicesPlaySystemSound(id)
    }
}
