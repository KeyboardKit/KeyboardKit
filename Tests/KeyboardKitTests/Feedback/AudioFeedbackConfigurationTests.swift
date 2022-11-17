//
//  AudioFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class AudioFeedbackConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("default initializer") {
            
            it("uses standard feedback") {
                let config = AudioFeedbackConfiguration()
                expect(config.input).to(equal(AudioFeedback.input))
                expect(config.delete).to(equal(AudioFeedback.delete))
                expect(config.system).to(equal(AudioFeedback.system))
            }
        }
        
        describe("enabled configuration") {
            
            it("uses standard feedback") {
                let config = AudioFeedbackConfiguration.enabled
                expect(config).to(equal(AudioFeedbackConfiguration()))
            }
        }
        
        describe("no feedback configuration") {
            
            it("disables all feedback") {
                let config = AudioFeedbackConfiguration.noFeedback
                expect(config.input).to(equal(AudioFeedback.none))
                expect(config.delete).to(equal(AudioFeedback.none))
                expect(config.system).to(equal(AudioFeedback.none))
            }
        }
        
        describe("standard configuration") {
            
            it("uses standard feedback") {
                let config = AudioFeedbackConfiguration.standard
                expect(config).to(equal(AudioFeedbackConfiguration()))
            }
        }
    }
}
