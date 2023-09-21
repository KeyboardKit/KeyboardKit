//
//  AudioFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import XCTest
@testable import KeyboardKit

class AudioFeedbackTests: XCTestCase {
    
    var engine: MockAudioFeedbackEngine!

    override func setUp() {
        engine = MockAudioFeedbackEngine()
        AudioFeedback.Engine.shared = engine
    }

    func id(for feedback: AudioFeedback) -> UInt32? {
        feedback.id
    }

    func testAudioFeedbackHasValidSystemId() {
        XCTAssertEqual(id(for: .input), 1104)
        XCTAssertEqual(id(for: .system), 1156)
        XCTAssertEqual(id(for: .delete), 1155)
        XCTAssertEqual(id(for: .custom(id: 123)), 123)
        XCTAssertEqual(id(for: .none), 0)
    }

    func testTriggeringFeedbackUsesSharedAudioEngine() {
        AudioFeedback.custom(id: 111).trigger()
        AudioFeedback.custom(id: 124).trigger()
        let calls = engine.calls(to: \.triggerRef)
        XCTAssertEqual(calls.count, 2)
        XCTAssertEqual(calls[0].arguments.id, 111)
        XCTAssertEqual(calls[1].arguments.id, 124)
    }
}
