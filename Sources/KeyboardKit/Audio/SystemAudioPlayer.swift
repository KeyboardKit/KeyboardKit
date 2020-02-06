//
//  SystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//

import Foundation

/**
 This protocol can be implemented by classes that can play a
 system audio sound, referred by id.
 */
public protocol SystemAudioPlayer {
    
    func playSystemAudio(_ id: UInt32)
}
