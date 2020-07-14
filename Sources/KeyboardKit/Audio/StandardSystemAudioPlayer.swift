//
//  StandardSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import AudioToolbox

/**
 This class plays system audio using `AudioToolbox`.
 */
public class StandardSystemAudioPlayer: SystemAudioPlayer {
    
    public func playSystemAudio(_ id: UInt32) {
        AudioServicesPlaySystemSound(id)
    }
}
