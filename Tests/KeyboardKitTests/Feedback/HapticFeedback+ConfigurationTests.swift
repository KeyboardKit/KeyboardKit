//
//  HapticFeedback+ConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class HapticFeedback_ConfigurationTests: XCTestCase {
    
    func testDefaultInitilizerUsesStandardFeedback() {
        let config = HapticFeedback.Configuration()
        XCTAssertEqual(config.press, HapticFeedback.none)
        XCTAssertEqual(config.release, HapticFeedback.none)
        XCTAssertEqual(config.doubleTap, HapticFeedback.none)
        XCTAssertEqual(config.longPress, HapticFeedback.none)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, HapticFeedback.none)
    }

    func testEnabledConfigurationEnabledAllFeedback() {
        let config = HapticFeedback.Configuration.enabled
        XCTAssertEqual(config.press, .lightImpact)
        XCTAssertEqual(config.release, .lightImpact)
        XCTAssertEqual(config.doubleTap, .lightImpact)
        XCTAssertEqual(config.longPress, .mediumImpact)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, .selectionChanged)
    }

    func testDisabledConfigurationUsesDisabledFeedback() {
        let config = HapticFeedback.Configuration.disabled
        XCTAssertEqual(config.press, .none)
        XCTAssertEqual(config.release, .none)
        XCTAssertEqual(config.doubleTap, .none)
        XCTAssertEqual(config.longPress, .none)
        XCTAssertEqual(config.longPressOnSpace, .none)
        XCTAssertEqual(config.repeat, .none)
    }

    func testMinimalConfigurationUsesMinimalFeedback() {
        let config = HapticFeedback.Configuration.minimal
        XCTAssertEqual(config.press, .none)
        XCTAssertEqual(config.release, .none)
        XCTAssertEqual(config.doubleTap, .none)
        XCTAssertEqual(config.longPress, .none)
        XCTAssertEqual(config.longPressOnSpace, .mediumImpact)
        XCTAssertEqual(config.repeat, .none)
    }
}
