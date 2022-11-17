//
//  MockAudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockAudioFeedbackEngine: Mock, AudioFeedbackEngine {
    
    lazy var triggerRef = MockReference(trigger)
    
    func trigger(_ audio: AudioFeedback) {
        call(triggerRef, args: (audio))
    }
}
