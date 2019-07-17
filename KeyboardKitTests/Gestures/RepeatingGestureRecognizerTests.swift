//
//  RepeatingGestureRecognizerTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-31.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockNRoll
@testable import KeyboardKit

class RepeatingGestureRecognizerTests: QuickSpec {
    
    override func spec() {
        
        var recognizer: TestClass!
        var triggerCount = 0
        
        beforeEach {
            triggerCount = 0
            recognizer = TestClass {
                triggerCount += 1
            }
        }
        
        describe("setting state") {
            
            func validateStartStopCount(_ startCount: Int, _ stopCount: Int) {
                let start = recognizer.recorder.executions(of: recognizer.startGesture)
                let stop = recognizer.recorder.executions(of: recognizer.stopGesture)
                expect(start.count).to(equal(startCount))
                expect(stop.count).to(equal(stopCount))
            }
            
            it("starts timer for began") {
                recognizer.state = .began
                validateStartStopCount(1, 0)
            }
            
            it("stops timer for ending states") {
                recognizer.state = .cancelled
                recognizer.state = .ended
                recognizer.state = .failed
                validateStartStopCount(0, 3)
            }
            
            it("does nothing for possible state") {
                recognizer.state = .possible
                validateStartStopCount(0, 0)
            }
            
            it("starts timer for changed state, since it also triggers began") {
                recognizer.state = .began
                validateStartStopCount(1, 0)
            }
        }
        
        
        describe("detecting touches") {
            
            it("sets began state for touches began") {
                recognizer.touchesBegan(Set<UITouch>(), with: .init())
                expect(recognizer.setStates[0]).to(equal(.began))
            }
            
            it("does not set changes state for touches moved if state is cancelled") {
                recognizer.state = .cancelled
                recognizer.touchesMoved(Set<UITouch>(), with: .init())
                expect(recognizer.setStates.count).to(equal(1))
                expect(recognizer.setStates[0]).toNot(equal(.changed))
            }
            
            it("does not set changes state for touches moved if state is ended") {
                recognizer.state = .ended
                recognizer.touchesMoved(Set<UITouch>(), with: .init())
                expect(recognizer.setStates.count).to(equal(1))
                expect(recognizer.setStates[0]).toNot(equal(.changed))
            }
            
            it("does not set changes state for touches moved if state is failed") {
                recognizer.state = .failed
                recognizer.touchesMoved(Set<UITouch>(), with: .init())
                expect(recognizer.setStates.count).to(equal(1))
                expect(recognizer.setStates[0]).toNot(equal(.changed))
            }
            
            it("sets changes state for touches moved if state is something else") {
                recognizer.state = .began
                recognizer.touchesMoved(Set<UITouch>(), with: .init())
                expect(recognizer.setStates.count).to(equal(2))
                expect(recognizer.setStates[0]).to(equal(.began))
                expect(recognizer.setStates[1]).to(equal(.changed))
            }
            
            it("sets cancelled state which transitions to failed for touches cancelled") {
                recognizer.touchesCancelled(Set<UITouch>(), with: .init())
                expect(recognizer.setStates[0]).to(equal(.failed))
            }
            
            it("sets ended state for touches ended") {
                recognizer.touchesEnded(Set<UITouch>(), with: .init())
                expect(recognizer.setStates[0]).to(equal(.ended))
            }
        }
        
        
        describe("starting timer") {
            
            it("performs action") {
                recognizer.startGesture()
                expect(triggerCount).to(equal(1))
            }
            
            it("creates timer") {
                recognizer.startGesture()
                expect(recognizer.timer).toNot(beNil())
            }
        }
        
        
        describe("stopping timer") {
            
            it("invalidates and deallocates timer") {
                recognizer.stopGesture()
                expect(recognizer.timer).to(beNil())
            }
        }
    }
}

private class TestClass: RepeatingGestureRecognizer {
    
    var recorder = Mock()
    
    var setStates = [UIGestureRecognizer.State]()
    
    override var state: UIGestureRecognizer.State {
        didSet { setStates.append(state) }
    }
    
    override func startGesture() {
        recorder.invoke(startGesture, args: ())
        super.startGesture()
    }
    
    override func stopGesture() {
        recorder.invoke(stopGesture, args: ())
        super.stopGesture()
    }
    
    override func delay(seconds: TimeInterval, function: @escaping () -> ()) {
        function()
    }
}
