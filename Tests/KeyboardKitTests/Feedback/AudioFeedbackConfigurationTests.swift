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
                expect(config.input).to(equal(SystemAudio.input))
                expect(config.delete).to(equal(SystemAudio.delete))
                expect(config.system).to(equal(SystemAudio.system))
            }
        }
        
        describe("no feedback configuration") {
            
            it("disables all feedback") {
                let config = AudioFeedbackConfiguration.noFeedback
                expect(config.input).to(equal(SystemAudio.none))
                expect(config.delete).to(equal(SystemAudio.none))
                expect(config.system).to(equal(SystemAudio.none))
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
