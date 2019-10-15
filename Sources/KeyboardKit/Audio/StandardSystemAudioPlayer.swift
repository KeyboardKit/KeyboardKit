//
//  StandardSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//

import AudioToolbox

public class StandardSystemAudioPlayer: SystemAudioPlayer {
    
    public func playSystemAudio(_ id: UInt32) {
        AudioServicesPlaySystemSound(id)
    }
}
