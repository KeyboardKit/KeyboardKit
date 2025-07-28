//
//  KeyboardLayout+DeviceConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KeyboardLayout_DeviceConfigurationTests: XCTestCase {

    func testStandardConfigIsCorrectForPadInPortrait() {
        let config = KeyboardLayout.DeviceConfiguration.standardPad
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 5, vertical: 5))
        XCTAssertEqual(config.rowHeight, 64)
    }
    
    func testStandardConfigIsCorrectForPadInLandscape() {
        let config = KeyboardLayout.DeviceConfiguration.standardPadLandscape
        XCTAssertEqual(config.buttonCornerRadius, 7)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 7, vertical: 6))
        XCTAssertEqual(config.rowHeight, 86)
    }

    func testStandardConfigIsCorrectForPhoneInPortrait() {
        let config = KeyboardLayout.DeviceConfiguration.standardPhone
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 5))
        XCTAssertEqual(config.rowHeight, 54)
    }

    func testStandardConfigIsCorrectForPhoneInLandscape() {
        let config = KeyboardLayout.DeviceConfiguration.standardPhoneLandscape
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 4))
        XCTAssertEqual(config.rowHeight, 40)
    }

    func testStandardConfigIsCorrectForProMaxPhoneInPortrait() {
        let config = KeyboardLayout.DeviceConfiguration.standardPhoneLarge
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 5.5))
        XCTAssertEqual(config.rowHeight, 56)
    }

    func testStandardConfigIsCorrectForProMaxPhoneInLandscape() {
        let config = KeyboardLayout.DeviceConfiguration.standardPhoneLargeLandscape
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 4))
        XCTAssertEqual(config.rowHeight, 40)
    }


    func configuration(
        for device: DeviceType,
        size: CGSize,
        orientation: InterfaceOrientation
    ) -> KeyboardLayout.DeviceConfiguration {
        .standard(
            forDevice: device,
            screenSize: size,
            orientation: orientation
        )
    }

    func testStandardKeyboardConfigurationForExplicitOrientations() {
        var config = configuration(for: .pad, size: .iPadLargeScreenLandscape, orientation: .landscapeRight)
        XCTAssertEqual(config.buttonCornerRadius, 8)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 7, vertical: 5))
        XCTAssertEqual(config.rowHeight, 88)

        config = configuration(for: .pad, size: .iPadLargeScreen, orientation: .portrait)
        XCTAssertEqual(config.buttonCornerRadius, 6)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 4, vertical: 4))
        XCTAssertEqual(config.rowHeight, 69)


        config = configuration(for: .phone, size: .zero, orientation: .landscapeRight)
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 4))
        XCTAssertEqual(config.rowHeight, 40)

        config = configuration(for: .phone, size: .zero, orientation: .portrait)
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 5))
        XCTAssertEqual(config.rowHeight, 54)


        config = configuration(for: .phone, size: .zero, orientation: .landscapeRight)
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 4))
        XCTAssertEqual(config.rowHeight, 40)

        config = configuration(for: .phone, size: .iPhoneLargeScreen, orientation: .portrait)
        XCTAssertEqual(config.buttonCornerRadius, 5)
        XCTAssertEqual(config.buttonInsets, .init(horizontal: 3, vertical: 5.5))
        XCTAssertEqual(config.rowHeight, 56)
    }
}
