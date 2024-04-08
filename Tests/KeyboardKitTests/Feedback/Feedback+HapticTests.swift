//
//  Feedback+HapticTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import XCTest
@testable import KeyboardKit

class Feedback_HapticTests: XCTestCase {

    var engine: MockHapticFeedbackEngine!

    override func setUp() {
        engine = MockHapticFeedbackEngine()
        Feedback.HapticEngine.shared = engine
    }

    func testPreparingFeedbackUsesSharedAudioEngine() {
        Feedback.Haptic.success.prepare()
        Feedback.Haptic.warning.prepare()
        let calls = engine.calls(to: \.prepareRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments, .success)
        XCTAssertEqual(calls[1].arguments, .warning)
    }

    func testTriggeringFeedbackUsesSharedAudioEngine() {
        Feedback.Haptic.success.trigger()
        Feedback.Haptic.warning.trigger()
        let calls = engine.calls(to: \.triggerRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments, .success)
        XCTAssertEqual(calls[1].arguments, .warning)
    }
}
