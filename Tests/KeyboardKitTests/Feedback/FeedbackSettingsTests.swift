//
//  FeedbackSettingsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class FeedbackSettingsTests: XCTestCase {
    
    func testFeedbackSettingsUsesStandardConfigurationsByDefault() {
        let settings = KeyboardFeedbackSettings()
        XCTAssertEqual(settings.audioConfiguration, .standard)
        XCTAssertEqual(settings.hapticConfiguration, .standard)
    }

    func testFeedbackSettingsCanUseCustomConfigurations() {
        let audio = AudioFeedbackConfiguration(input: .delete, delete: .input, system: .system)
        let haptic = HapticFeedbackConfiguration(tap: .error, doubleTap: .warning, longPress: .success, longPressOnSpace: .lightImpact, repeat: .error)
        let settings = KeyboardFeedbackSettings(audioConfiguration: audio, hapticConfiguration: haptic)
        XCTAssertNotEqual(settings.audioConfiguration, .standard)
        XCTAssertNotEqual(settings.hapticConfiguration, .standard)
        XCTAssertEqual(settings.audioConfiguration, audio)
        XCTAssertEqual(settings.hapticConfiguration, haptic)
    }
}
