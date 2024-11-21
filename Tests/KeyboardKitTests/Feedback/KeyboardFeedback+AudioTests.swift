//
//  KeyboardFeedback+AudioTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import XCTest
@testable import KeyboardKit

class KeyboardFeedback_AudioTests: XCTestCase {

    func id(for feedback: KeyboardFeedback.Audio) -> UInt32? {
        feedback.id
    }

    func testAudioFeedbackHasValidSystemId() {
        XCTAssertEqual(id(for: .input), 1104)
        XCTAssertEqual(id(for: .system), 1156)
        XCTAssertEqual(id(for: .delete), 1155)
        XCTAssertEqual(id(for: .customId(123)), 123)
        XCTAssertEqual(id(for: .none), 0)
    }
}
