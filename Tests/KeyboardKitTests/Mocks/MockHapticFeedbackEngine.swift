//
//  MockHapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import MockingKit
@testable import KeyboardKit

class MockHapticFeedbackEngine: HapticFeedback.Engine, Mockable {

    var mock = Mock()
    
    lazy var prepareRef = MockReference(prepare)
    lazy var triggerRef = MockReference(trigger)
    
    override func prepare(_ feedback: HapticFeedback) {
        call(prepareRef, args: (feedback))
    }

    override func trigger(_ feedback: HapticFeedback) {
        call(triggerRef, args: (feedback))
    }
}
