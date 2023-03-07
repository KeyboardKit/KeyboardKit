//
//  MockHapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit

class MockHapticFeedbackEngine: Mock, HapticFeedbackEngine {

    lazy var prepareRef = MockReference(prepare)
    lazy var triggerRef = MockReference(trigger)
    
    func prepare(_ feedback: HapticFeedback) {
        call(prepareRef, args: (feedback))
    }

    func trigger(_ feedback: HapticFeedback) {
        call(triggerRef, args: (feedback))
    }
}
