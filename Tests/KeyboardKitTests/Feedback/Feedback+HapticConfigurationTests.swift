//
//  Feedback+HapticConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Feedback_HapticConfigurationTests: XCTestCase {
    
    typealias Config = Feedback.HapticConfiguration
    
    func testDefaultInitilizerUsesStandardFeedback() {
        let config = Config()
        XCTAssertEqual(config.press, Feedback.Haptic.none)
        XCTAssertEqual(config.release, Feedback.Haptic.none)
        XCTAssertEqual(config.doubleTap, Feedback.Haptic.none)
        XCTAssertEqual(config.longPress, Feedback.Haptic.none)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, Feedback.Haptic.none)
    }

    func testEnabledConfigurationEnabledAllFeedback() {
        let config = Config.enabled
        XCTAssertEqual(config.press, .selectionChanged)
        XCTAssertEqual(config.release, .selectionChanged)
        XCTAssertEqual(config.doubleTap, .lightImpact)
        XCTAssertEqual(config.longPress, .mediumImpact)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, .selectionChanged)
    }

    func testDisabledConfigurationUsesMinimalFeedback() {
        let config = Config.disabled
        XCTAssertEqual(config.press, .none)
        XCTAssertEqual(config.release, .none)
        XCTAssertEqual(config.doubleTap, .none)
        XCTAssertEqual(config.longPress, .none)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, .none)
    }
}
