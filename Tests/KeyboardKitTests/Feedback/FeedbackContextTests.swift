//
//  FeedbackContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class FeedbackContextTests: XCTestCase {

    override func tearDown() {
        FeedbackContext().settings.isAudioFeedbackEnabled = true
        FeedbackContext().settings.isHapticFeedbackEnabled = false
    }

    func testContextUsesExpectedConfigurationsByDefault() {
        let settings = FeedbackContext()
        XCTAssertEqual(settings.audioConfiguration, .standard)
        XCTAssertEqual(settings.hapticConfiguration, .standard)
    }
}
