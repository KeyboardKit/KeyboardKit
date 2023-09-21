//
//  AudioFeedback+ConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class AudioFeedback_ConfigurationTests: XCTestCase {

    func testDefaultInitializerUsesStandardFeedback() {
        let config = AudioFeedback.Configuration()
        XCTAssertEqual(config.input, AudioFeedback.input)
        XCTAssertEqual(config.delete, AudioFeedback.delete)
        XCTAssertEqual(config.system, AudioFeedback.system)
    }

    func testEnabledConfigurationUsesEnabledFeedback() {
        let config = AudioFeedback.Configuration.enabled
        XCTAssertEqual(config, AudioFeedback.Configuration())
    }

    func testDisabledConfigurationUsesDisabledFeedback() {
        let config = AudioFeedback.Configuration.disabled
        XCTAssertEqual(config.input, AudioFeedback.none)
        XCTAssertEqual(config.delete, AudioFeedback.none)
        XCTAssertEqual(config.system, AudioFeedback.none)
    }
}
