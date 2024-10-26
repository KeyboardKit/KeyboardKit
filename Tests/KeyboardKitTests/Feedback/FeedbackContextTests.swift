//
//  FeedbackContextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
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
        XCTAssertEqual(settings.audioConfiguration, .enabled)
        XCTAssertEqual(settings.hapticConfiguration, .disabled)
    }

    func testContextCanCustomizeAudioFeedback() {
        let context = FeedbackContext()
        let audio = Feedback.AudioConfiguration(input: .delete)

        context.audioConfiguration = audio
        XCTAssertTrue(context.settings.isAudioFeedbackEnabled)
        XCTAssertEqual(context.audioConfiguration, audio)
        XCTAssertNotEqual(context.audioConfiguration, .disabled)
        
        context.settings.toggleIsAudioFeedbackEnabled()
        XCTAssertFalse(context.settings.isAudioFeedbackEnabled)
        XCTAssertNotEqual(context.audioConfiguration, audio)
        XCTAssertEqual(context.audioConfiguration, .disabled)
        
        context.settings.toggleIsAudioFeedbackEnabled()
        XCTAssertTrue(context.settings.isAudioFeedbackEnabled)
        XCTAssertEqual(context.audioConfiguration, audio)
        XCTAssertNotEqual(context.audioConfiguration, .disabled)
    }

    func testContextCanCustomizeHapticFeedback() {
        let context = FeedbackContext()
        let haptic = Feedback.HapticConfiguration(press: .error)

        context.hapticConfiguration = haptic
        XCTAssertFalse(context.settings.isHapticFeedbackEnabled)
        XCTAssertNotEqual(context.hapticConfiguration, haptic)
        XCTAssertEqual(context.hapticConfiguration, .disabled)

        context.settings.toggleIsHapticFeedbackEnabled()
        XCTAssertTrue(context.settings.isHapticFeedbackEnabled)
        XCTAssertEqual(context.hapticConfiguration, haptic)
        XCTAssertNotEqual(context.hapticConfiguration, .disabled)
        
        context.settings.toggleIsHapticFeedbackEnabled()
        XCTAssertFalse(context.settings.isHapticFeedbackEnabled)
        XCTAssertNotEqual(context.hapticConfiguration, haptic)
        XCTAssertEqual(context.hapticConfiguration, .disabled)
    }
}
