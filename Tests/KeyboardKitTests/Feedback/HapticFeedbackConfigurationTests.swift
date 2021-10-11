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
                expect(config.tap).to(equal(HapticFeedback.none))
                expect(config.doubleTap).to(equal(HapticFeedback.none))
                expect(config.longPress).to(equal(HapticFeedback.none))
                expect(config.longPressOnSpace).to(equal(.mediumImpact))
                expect(config.repeat).to(equal(HapticFeedback.none))
            }
        }
        
        describe("enabled configuration") {
            
            it("enabled all feedback") {
                let config = HapticFeedbackConfiguration.enabled
                expect(config.tap).to(equal(.lightImpact))
                expect(config.doubleTap).to(equal(.lightImpact))
                expect(config.longPress).to(equal(.mediumImpact))
                expect(config.longPressOnSpace).to(equal(.mediumImpact))
                expect(config.repeat).to(equal(.selectionChanged))
            }
        }
        
        describe("no feedback configuration") {
            
            it("disables all feedback") {
                let config = HapticFeedbackConfiguration.noFeedback
                expect(config.tap).to(equal(HapticFeedback.none))
                expect(config.doubleTap).to(equal(HapticFeedback.none))
                expect(config.longPress).to(equal(HapticFeedback.none))
                expect(config.longPressOnSpace).to(equal(HapticFeedback.none))
                expect(config.repeat).to(equal(HapticFeedback.none))
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
