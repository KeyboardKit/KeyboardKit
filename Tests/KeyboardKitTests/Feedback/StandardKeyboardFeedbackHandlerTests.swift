//
//  StandardKeyboardFeedbackHandlerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class StandardKeyboardFeedbackHandlerTests: QuickSpec {
    
    typealias Action = KeyboardFeedbackHandler.GestureAction
    typealias ActionProvider = KeyboardFeedbackHandler.GestureActionProvider
    
    override func spec() {
        
        var handler: StandardKeyboardFeedbackHandler!
        
        var audioPlayer: MockSystemAudioPlayer!
        var actionProvider: ActionProvider!
        var gestureAction: Action!
        var hapticPlayer: MockHapticFeedbackPlayer!
        
        beforeEach {
            audioPlayer = MockSystemAudioPlayer()
            actionProvider = { _, _ in return nil }
            gestureAction = { _ in }
            hapticPlayer = MockHapticFeedbackPlayer()
            
            handler = StandardKeyboardFeedbackHandler(settings: KeyboardFeedbackSettings())
            
            StandardSystemAudioPlayer.shared = audioPlayer
            StandardHapticFeedbackPlayer.shared = hapticPlayer
        }
        
        describe("should trigger feedback") {
            
            it("returns false for press if no action is performed for tap") {
                let res = handler.shouldTriggerFeedback(for: .press, on: .character(""), actionProvider: actionProvider)
                expect(res).to(beFalse())
            }
            
            it("returns true for press if an action is performed for tap") {
                actionProvider = { gesture, _ in return gesture == .tap ? gestureAction : nil }
                let res = handler.shouldTriggerFeedback(for: .press, on: .character(""), actionProvider: actionProvider)
                expect(res).to(beTrue())
            }
            
            it("returns true for tap even if an action is performed for tap") {
                actionProvider = { gesture, _ in return gesture == .tap ? gestureAction : nil }
                let res = handler.shouldTriggerFeedback(for: .tap, on: .character(""), actionProvider: actionProvider)
                expect(res).to(beFalse())
            }
            
            it("returns false for not tap but no action is performed for the gesture") {
                actionProvider = { gesture, _ in return gesture == .longPress ? gestureAction : nil }
                let res = handler.shouldTriggerFeedback(for: .release, on: .character(""), actionProvider: actionProvider)
                expect(res).to(beFalse())
            }
            
            it("returns true for not tap and an action is performed for the gesture") {
                actionProvider = { gesture, _ in return gesture == .longPress ? gestureAction : nil }
                let res = handler.shouldTriggerFeedback(for: .longPress, on: .character(""), actionProvider: actionProvider)
                expect(res).to(beTrue())
            }
        }
        
        describe("trigger feedback with action provider") {
            
            it("aborts if no action should be performed") {
                handler.triggerFeedback(for: .press, on: .backspace, actionProvider: actionProvider)
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beFalse())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beFalse())
            }
            
            it("triggers audio and haptic feedback") {
                actionProvider = { gesture, _ in return gesture == .tap ? gestureAction : nil }
                handler.triggerFeedback(for: .press, on: .backspace, actionProvider: actionProvider)
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beTrue())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
        
        describe("trigger feedback") {
            
            it("triggers audio and haptic feedback") {
                handler.triggerFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beTrue())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
        
        describe("trigger feedback for long press on space drag gesture") {
            
            it("triggers haptic feedback") {
                handler.triggerFeedbackForLongPressOnSpaceDragGesture()
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beFalse())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
        
        describe("trigger audio feedback") {
            
            it("triggers audio feedback only") {
                handler.triggerAudioFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beTrue())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beFalse())
            }
        }
        
        describe("trigger haptic feedback") {
            
            it("triggers haptic feedback only") {
                handler.triggerHapticFeedback(for: .press, on: .backspace)
                expect(audioPlayer.hasCalled(audioPlayer.playSystemAudioRef)).to(beFalse())
                expect(hapticPlayer.hasCalled(hapticPlayer.playRef)).to(beTrue())
            }
        }
    }
}
