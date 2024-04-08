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
    
    func testFeedbackSettingsUsesStandardConfigurationsByDefault() {
        let settings = FeedbackConfiguration()
        XCTAssertEqual(settings.audio, .enabled)
        XCTAssertEqual(settings.haptic, .minimal)
    }

    func testFeedbackSettingsCanUseCustomConfigurations() {
        let audio = Feedback.AudioConfiguration(
            input: .delete,
            delete: .input,
            system: .system)
        let haptic = Feedback.HapticConfiguration(
            press: .error,
            release: .error,
            doubleTap: .warning,
            longPress: .success,
            longPressOnSpace: .lightImpact,
            repeat: .error)
        let settings = FeedbackConfiguration(
            audio: audio,
            haptic: haptic)
        XCTAssertNotEqual(settings.audio, .enabled)
        XCTAssertNotEqual(settings.haptic, .minimal)
        XCTAssertEqual(settings.audio, audio)
        XCTAssertEqual(settings.haptic, haptic)
    }
}
