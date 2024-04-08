//
//  MockHapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import MockingKit
@testable import KeyboardKit

class MockHapticFeedbackEngine: Feedback.HapticEngine, Mockable {

    var mock = Mock()
    
    lazy var prepareRef = MockReference(prepare)
    lazy var triggerRef = MockReference(trigger)
    
    override func prepare(_ feedback: Feedback.Haptic) {
        call(prepareRef, args: (feedback))
    }

    override func trigger(_ feedback: Feedback.Haptic) {
        call(triggerRef, args: (feedback))
    }
}
