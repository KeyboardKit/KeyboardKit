//
//  HapticFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import XCTest
@testable import KeyboardKit

class HapticFeedbackTests: XCTestCase {

    var engine: MockHapticFeedbackEngine!

    override func setUp() {
        engine = MockHapticFeedbackEngine()
        HapticFeedback.Engine.shared = engine
    }

    func testPreparingFeedbackUsesSharedAudioEngine() {
        HapticFeedback.success.prepare()
        HapticFeedback.warning.prepare()
        let calls = engine.calls(to: \.prepareRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments, .success)
        XCTAssertEqual(calls[1].arguments, .warning)
    }

    func testTriggeringFeedbackUsesSharedAudioEngine() {
        HapticFeedback.success.trigger()
        HapticFeedback.warning.trigger()
        let calls = engine.calls(to: \.triggerRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments, .success)
        XCTAssertEqual(calls[1].arguments, .warning)
    }
}
