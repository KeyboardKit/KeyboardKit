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
        XCTAssertEqual(settings.audioConfiguration, .enabled)
        XCTAssertEqual(settings.hapticConfiguration, .minimal)
    }

    func testFeedbackSettingsCanUseCustomConfigurations() {
        let audio = AudioFeedback.Configuration(input: .delete, delete: .input, system: .system)
        let haptic = HapticFeedback.Configuration(press: .error, release: .error, doubleTap: .warning, longPress: .success, longPressOnSpace: .lightImpact, repeat: .error)
        let settings = KeyboardFeedbackSettings(audioConfiguration: audio, hapticConfiguration: haptic)
        XCTAssertNotEqual(settings.audioConfiguration, .enabled)
        XCTAssertNotEqual(settings.hapticConfiguration, .minimal)
        XCTAssertEqual(settings.audioConfiguration, audio)
        XCTAssertEqual(settings.hapticConfiguration, haptic)
    }
}
