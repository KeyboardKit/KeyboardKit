//
//  RepeatGestureTimerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import KeyboardKit

class RepeatGestureTimerTests: QuickSpec {
    
    override func spec() {
    
        let timer = RepeatGestureTimer.shared
        
        afterEach {
            timer.stop()
        }
        
        describe("time interval") {
            
            it("is short") {
                expect(timer.timeInterval).to(equal(0.1))
            }
        }
        
        describe("duration") {
            
            it("is nil if the timer has not been started") {
                expect(timer.duration).to(beNil())
            }
            
            it("is not nil if the timer has been started but not stopped") {
                timer.start {}
                expect(timer.duration).toNot(beNil())
            }
            
            it("is nil if the timer has been started then stopped") {
                timer.start {}
                timer.stop()
                expect(timer.duration).to(beNil())
            }
            
            it("is the time that has passed since the timer started") {
                timer.start {}
                timer.modifyStartDate(to: Date().addingTimeInterval(-5))
                expect(timer.duration).to(beCloseTo(5))
            }
        }
        
        describe("is active") {
            
            it("is false if the timer has not been started") {
                expect(timer.isActive).to(beFalse())
            }
            
            it("is true if the timer has been started but not stopped") {
                timer.start {}
                expect(timer.isActive).to(beTrue())
            }
            
            it("is true if the timer has been started then stopped") {
                timer.start {}
                timer.stop()
                expect(timer.isActive).to(beFalse())
            }
        }
    }
}
