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
        
        var audioPlayer: MockAudioFeedbackPlayer!
        var hapticPlayer: MockHapticFeedbackPlayer!
        
        beforeEach {
            audioPlayer = MockAudioFeedbackPlayer()
            hapticPlayer = MockHapticFeedbackPlayer()
            
            handler = StandardKeyboardFeedbackHandler(settings: KeyboardFeedbackSettings())
            
            AudioFeedback.player = audioPlayer
            HapticFeedback.player = hapticPlayer
        }
        
        describe("trigger feedback") {
            
            it("triggers audio and haptic feedback") {
                handler.triggerFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playRef)).to(beTrue())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
        
        describe("trigger audio feedback") {
            
            it("triggers audio feedback only") {
                handler.triggerAudioFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playRef)).to(beTrue())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beFalse())
            }
        }
        
        describe("trigger haptic feedback") {
            
            it("triggers haptic feedback only") {
                handler.triggerHapticFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playRef)).to(beFalse())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
    }
}
#endif
