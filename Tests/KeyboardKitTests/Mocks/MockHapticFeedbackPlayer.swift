//
//  MockHapticFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockHapticFeedbackPlayer: Mock, HapticFeedbackPlayer {
    
    lazy var playRef = MockReference(play)
    lazy var prepareRef = MockReference(prepare)
    
    func play(_ feedback: HapticFeedback) {
        call(playRef, args: (feedback))
    }
    
    func prepare(_ feedback: HapticFeedback) {
        call(prepareRef, args: (feedback))
    }
}
