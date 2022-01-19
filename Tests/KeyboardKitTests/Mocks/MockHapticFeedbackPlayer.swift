//
//  MockHapticFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

#if os(iOS) || os(macOS)
class MockHapticFeedbackPlayer: StandardHapticFeedbackPlayer, Mockable {
    
    let mock = Mock()
    
    lazy var playRef = MockReference(play)
    lazy var prepareRef = MockReference(prepare)
    
    override func play(_ feedback: HapticFeedback) {
        call(playRef, args: (feedback))
    }
    
    override func prepare(_ feedback: HapticFeedback) {
        call(prepareRef, args: (feedback))
    }
}
#endif
