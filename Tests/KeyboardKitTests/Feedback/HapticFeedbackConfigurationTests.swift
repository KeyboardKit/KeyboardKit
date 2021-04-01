//
//  HapticFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class HapticFeedbackConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("default initilizer") {
            
            it("uses standard feedback") {
                let config = HapticFeedbackConfiguration()
                expect(config.tapFeedback).to(equal(HapticFeedback.none))
                expect(config.doubleTapFeedback).to(equal(HapticFeedback.none))
                expect(config.longPressFeedback).to(equal(HapticFeedback.none))
                expect(config.longPressOnSpaceFeedback).to(equal(.mediumImpact))
                expect(config.repeatFeedback).to(equal(HapticFeedback.none))
            }
        }
        
        describe("no feedback configuration") {
            
            it("disables all feedback") {
                let config = HapticFeedbackConfiguration.noFeedback
                expect(config.tapFeedback).to(equal(HapticFeedback.none))
                expect(config.doubleTapFeedback).to(equal(HapticFeedback.none))
                expect(config.longPressFeedback).to(equal(HapticFeedback.none))
                expect(config.longPressOnSpaceFeedback).to(equal(HapticFeedback.none))
                expect(config.repeatFeedback).to(equal(HapticFeedback.none))
            }
        }
        
        describe("standard configuration") {
            
            it("uses standard feedback") {
                let config = HapticFeedbackConfiguration.standard
                expect(config).to(equal(HapticFeedbackConfiguration()))
            }
        }
    }
}
