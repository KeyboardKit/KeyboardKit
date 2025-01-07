//
//  KeyboardFeedback+AudioConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardFeedback_AudioConfigurationTests: XCTestCase {

    typealias Config = KeyboardFeedback.AudioConfiguration
    
    func testDefaultInitializerUsesStandardFeedback() {
        let config = Config()
        XCTAssertEqual(config, .standard)
    }

    func testStandardConfigurationEnablesFeedback() {
        let config = Config()
        XCTAssertEqual(config.input, KeyboardFeedback.Audio.input)
        XCTAssertEqual(config.delete, KeyboardFeedback.Audio.delete)
        XCTAssertEqual(config.system, KeyboardFeedback.Audio.system)
    }

    func testDisabledConfigurationUsesDisabledFeedback() {
        let config = Config.disabled
        XCTAssertEqual(config.input, KeyboardFeedback.Audio.none)
        XCTAssertEqual(config.delete, KeyboardFeedback.Audio.none)
        XCTAssertEqual(config.system, KeyboardFeedback.Audio.none)
    }
}
