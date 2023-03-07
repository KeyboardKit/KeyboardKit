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

    func testEnabledConfigurationUsesstandardFeedback() {
        let config = AudioFeedbackConfiguration.enabled
        XCTAssertEqual(config, AudioFeedbackConfiguration())
    }

    func testNoFeedbackConfigurationDisablesAllFeedback() {
        let config = AudioFeedbackConfiguration.noFeedback
        XCTAssertEqual(config.input, AudioFeedback.none)
        XCTAssertEqual(config.delete, AudioFeedback.none)
        XCTAssertEqual(config.system, AudioFeedback.none)
    }

    func testStandardConfigurationUsesStandardFeedback() {
        let config = AudioFeedbackConfiguration.standard
        XCTAssertEqual(config, AudioFeedbackConfiguration())
    }
}
