//
//  MockSystemAudioPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockSystemAudioPlayer: StandardSystemAudioPlayer, Mockable {
    
    let mock = Mock()
    
    lazy var playRef = MockReference(play)
    
    override func play(_ audio: SystemAudio) {
        call(playRef, args: (audio))
    }
}
