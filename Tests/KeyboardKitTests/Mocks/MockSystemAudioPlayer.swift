//
//  MockSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockSystemAudioPlayer: Mock, SystemAudioPlayer {
    
    lazy var playSystemAudioRef = MockReference(playSystemAudio)
    
    func playSystemAudio(_ id: UInt32) {
        call(playSystemAudioRef, args: (id))
    }
}
