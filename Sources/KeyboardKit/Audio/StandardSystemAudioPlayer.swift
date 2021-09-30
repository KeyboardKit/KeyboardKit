//
//  StandardSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import AudioToolbox

/**
 This class plays system audio using `AudioToolbox`.
 */
public class StandardSystemAudioPlayer: SystemAudioPlayer {
    
    /**
     Play a certain system audio sound.
     **/
    public func playSystemAudio(_ audio: SystemAudio) {
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
    static var shared: SystemAudioPlayer = StandardSystemAudioPlayer()
}
