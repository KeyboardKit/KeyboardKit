//
//  AudioFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class AudioFeedbackConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("no feedback configuration") {
            
            it("uses none for all") {
                let config = AudioFeedbackConfiguration.noFeedback
                expect(config.inputFeedback).to(equal(AudioFeedback.none))
                expect(config.deleteFeedback).to(equal(AudioFeedback.none))
                expect(config.systemFeedback).to(equal(AudioFeedback.none))
            }
        }
        
        describe("standard configuration") {
            
            it("uses standard Audio feedbacks") {
                let config = AudioFeedbackConfiguration.standard
                expect(config.inputFeedback).to(equal(AudioFeedback.input))
                expect(config.deleteFeedback).to(equal(AudioFeedback.delete))
                expect(config.systemFeedback).to(equal(AudioFeedback.system))
            }
        }
    }
}
