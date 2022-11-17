//
//  StandardKeyboardFeedbackHandlerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Quick
import Nimble
import KeyboardKit

class StandardKeyboardFeedbackHandlerTests: QuickSpec {
    
    override func spec() {
        
        var handler: StandardKeyboardFeedbackHandler!
        
        var audioEngine: MockAudioFeedbackEngine!
        var hapticEngine: MockHapticFeedbackEngine!
        
        beforeEach {
            audioEngine = MockAudioFeedbackEngine()
            hapticEngine = MockHapticFeedbackEngine()
            
            handler = StandardKeyboardFeedbackHandler(settings: KeyboardFeedbackSettings())
            
            AudioFeedback.engine = audioEngine
            HapticFeedback.engine = hapticEngine
        }
        
        describe("trigger feedback") {
            
            it("triggers audio and haptic feedback") {
                handler.triggerFeedback(for: .press, on: .backspace)
                expect(audioEngine.hasCalled(audioEngine.triggerRef)).to(beTrue())
                expect(hapticEngine.hasCalled(hapticEngine.triggerRef)).to(beTrue())
            }
        }
        
        describe("trigger audio feedback") {
            
            it("triggers audio feedback only") {
                handler.triggerAudioFeedback(for: .press, on: .backspace)
                expect(audioEngine.hasCalled(audioEngine.triggerRef)).to(beTrue())
                expect(hapticEngine.hasCalled(hapticEngine.triggerRef)).to(beFalse())
            }
        }
        
        describe("trigger haptic feedback") {
            
            it("triggers haptic feedback only") {
                handler.triggerHapticFeedback(for: .press, on: .backspace)
                expect(audioEngine.hasCalled(audioEngine.triggerRef)).to(beFalse())
                expect(hapticEngine.hasCalled(hapticEngine.triggerRef)).to(beTrue())
            }
        }
    }
}
#endif
