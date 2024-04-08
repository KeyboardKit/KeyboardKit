//
//  MockAudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import MockingKit
@testable import KeyboardKit

class MockAudioFeedbackEngine: Feedback.AudioEngine, Mockable {
    
    var mock = Mock()
    
    lazy var triggerRef = MockReference(trigger)
    
    override func trigger(_ audio: Feedback.Audio) {
        call(triggerRef, args: (audio))
    }
}
