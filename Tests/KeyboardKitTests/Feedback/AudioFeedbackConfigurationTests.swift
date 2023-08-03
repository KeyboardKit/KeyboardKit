//
//  AudioFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class AudioFeedbackConfigurationTests: XCTestCase {

    func testDefaultInitializerUsesStandardFeedback() {
        let config = AudioFeedbackConfiguration()
        XCTAssertEqual(config.input, AudioFeedback.input)
        XCTAssertEqual(config.delete, AudioFeedback.delete)
        XCTAssertEqual(config.system, AudioFeedback.system)
    }

    func testEnabledConfigurationUsesEnabledFeedback() {
        let config = AudioFeedbackConfiguration.enabled
        XCTAssertEqual(config, AudioFeedbackConfiguration())
    }

    func testDisabledConfigurationUsesDisabledFeedback() {
        let config = AudioFeedbackConfiguration.disabled
        XCTAssertEqual(config.input, AudioFeedback.none)
        XCTAssertEqual(config.delete, AudioFeedback.none)
        XCTAssertEqual(config.system, AudioFeedback.none)
    }
}
