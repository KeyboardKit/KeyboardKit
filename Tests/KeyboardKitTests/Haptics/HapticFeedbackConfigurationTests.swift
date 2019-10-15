//
//  HapticFeedbackConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class HapticFeedbackConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("no feedback configuration") {
            
            it("uses none for all") {
                let config = HapticFeedbackConfiguration.noFeedback
                expect(config.tapFeedback).to(equal(HapticFeedback.none))
                expect(config.longPressFeedback).to(equal(HapticFeedback.none))
                expect(config.repeatFeedback).to(equal(HapticFeedback.none))
            }
        }
        
        describe("standard configuration") {
            
            it("uses standard haptic feedbacks") {
                let config = HapticFeedbackConfiguration.standard
                expect(config.tapFeedback).to(equal(HapticFeedback.standardTapFeedback))
                expect(config.longPressFeedback).to(equal(HapticFeedback.standardLongPressFeedback))
                expect(config.repeatFeedback).to(equal(HapticFeedback.none))
            }
        }
    }
}
