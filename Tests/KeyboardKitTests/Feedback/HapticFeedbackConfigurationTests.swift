//
//  HapticFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class HapticFeedbackConfigurationTests: XCTestCase {
    
    func testDefaultInitilizerUsesStandardFeedback() {
        let config = HapticFeedbackConfiguration()
        XCTAssertEqual(config.press, HapticFeedback.none)
        XCTAssertEqual(config.release, HapticFeedback.none)
        XCTAssertEqual(config.doubleTap, HapticFeedback.none)
        XCTAssertEqual(config.longPress, HapticFeedback.none)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, HapticFeedback.none)
    }

    func testEnabledConfigurationEnabledAllFeedback() {
        let config = HapticFeedbackConfiguration.enabled
        XCTAssertEqual(config.press, HapticFeedback.lightImpact)
        XCTAssertEqual(config.release, HapticFeedback.lightImpact)
        XCTAssertEqual(config.doubleTap, .lightImpact)
        XCTAssertEqual(config.longPress, .mediumImpact)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, .selectionChanged)
    }

    func testNoFeedbackConfigurationDisablesAllFeedback() {
        let config = HapticFeedbackConfiguration.noFeedback
        XCTAssertEqual(config.press, HapticFeedback.none)
        XCTAssertEqual(config.release, HapticFeedback.none)
        XCTAssertEqual(config.doubleTap, HapticFeedback.none)
        XCTAssertEqual(config.longPress, HapticFeedback.none)
        XCTAssertEqual(config.longPressOnSpace, HapticFeedback.none)
        XCTAssertEqual(config.repeat, HapticFeedback.none)
    }

    func testStandardConfigurationUsesStandardFeedback() {
        let config = HapticFeedbackConfiguration.standard
        XCTAssertEqual(config, HapticFeedbackConfiguration())
    }
}
