//
//  KeyboardFeedbackContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardFeedbackContextTests: XCTestCase {

    override func tearDown() {
        KeyboardFeedbackContext().settings.isAudioFeedbackEnabled = true
        KeyboardFeedbackContext().settings.isHapticFeedbackEnabled = false
    }

    func testContextUsesExpectedConfigurationsByDefault() {
        let settings = KeyboardFeedbackContext()
        XCTAssertEqual(settings.audioConfiguration, .standard)
        XCTAssertEqual(settings.hapticConfiguration, .standard)
    }
}
