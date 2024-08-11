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
        let settings = FeedbackContext()
        XCTAssertEqual(settings.audioConfiguration, .enabled)
        XCTAssertEqual(settings.hapticConfiguration, .disabled)
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
        let settings = FeedbackContext(
            audioConfiguration: audio,
            hapticConfiguration: haptic)
        XCTAssertNotEqual(settings.audioConfiguration, .enabled)
        XCTAssertNotEqual(settings.hapticConfiguration, .disabled)
        XCTAssertEqual(settings.audioConfiguration, audio)
        XCTAssertEqual(settings.hapticConfiguration, haptic)
    }
}
