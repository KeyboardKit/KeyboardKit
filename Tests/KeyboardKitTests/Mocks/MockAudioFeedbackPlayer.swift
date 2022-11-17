//
//  MockAudioFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockAudioFeedbackPlayer: Mock, AudioFeedbackPlayer {
    
    lazy var playRef = MockReference(play)
    
    func play(_ audio: AudioFeedback) {
        call(playRef, args: (audio))
    }
}
