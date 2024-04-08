//
//  Feedback+AudioTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import XCTest
@testable import KeyboardKit

class Feedback_AudioTests: XCTestCase {
    
    var engine: MockAudioFeedbackEngine!

    override func setUp() {
        engine = MockAudioFeedbackEngine()
        Feedback.AudioEngine.shared = engine
    }

    func id(for feedback: Feedback.Audio) -> UInt32? {
        feedback.id
    }

    func testAudioFeedbackHasValidSystemId() {
        XCTAssertEqual(id(for: .input), 1104)
        XCTAssertEqual(id(for: .system), 1156)
        XCTAssertEqual(id(for: .delete), 1155)
        XCTAssertEqual(id(for: .customId(123)), 123)
        XCTAssertEqual(id(for: .none), 0)
    }

    func testTriggeringFeedbackUsesSharedAudioEngine() {
        Feedback.Audio.customId(111).trigger()
        Feedback.Audio.customId(124).trigger()
        let calls = engine.calls(to: \.triggerRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments.id, 111)
        XCTAssertEqual(calls[1].arguments.id, 124)
    }
}
