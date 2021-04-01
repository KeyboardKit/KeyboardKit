//
//  FeedbackSettingsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class FeedbackSettingsTests: QuickSpec {
    
    override func spec() {
        
        describe("feedback settings") {
            
            it("uses standard configurations by default") {
                let settings = FeedbackSettings()
                expect(settings.audioConfiguration).to(equal(.standard))
                expect(settings.hapticConfiguration).to(equal(.standard))
            }
            
            it("can use custom configurations") {
                let audio = AudioFeedbackConfiguration(inputFeedback: .delete, deleteFeedback: .input, systemFeedback: .system)
                let haptic = HapticFeedbackConfiguration(tapFeedback: .error, doubleTapFeedback: .warning, longPressFeedback: .success, longPressOnSpaceFeedback: .lightImpact, repeatFeedback: .error)
                let settings = FeedbackSettings(audioConfiguration: audio, hapticConfiguration: haptic)
                expect(settings.audioConfiguration).toNot(equal(.standard))
                expect(settings.hapticConfiguration).toNot(equal(.standard))
                expect(settings.audioConfiguration).to(equal(audio))
                expect(settings.hapticConfiguration).to(equal(haptic))
            }
        }
    }
}
