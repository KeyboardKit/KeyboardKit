//
//  StandardKeyboardActionHandlerTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Mockery
import KeyboardKit
import UIKit

class StandardKeyboardActionHandlerTests: QuickSpec {
    
    override func spec() {
        
        var handler: StandardKeyboardActionHandlerTestClass!
        var recorder: MockKeyboardActionHandler!
        var inputViewController: MockInputViewController!
        
        beforeEach {
            recorder = MockKeyboardActionHandler()
            inputViewController = MockInputViewController()
            handler = StandardKeyboardActionHandlerTestClass(
                recorder: recorder,
                inputViewController: inputViewController)
        }
        
        
        // MARK: - Actions
        
        describe("long press action") {
            
            func action(for action: KeyboardAction) -> Any? {
                return handler.longPressAction(for: action, sender: UIView())
            }
            
            it("is by default the tap action") {
                expect(action(for: .dismissKeyboard)).toNot(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        describe("repeat action") {
            
            func action(for action: KeyboardAction) -> Any? {
                return handler.repeatAction(for: action, sender: UIView())
            }
            
            it("is only applied to backspace") {
                expect(action(for: .dismissKeyboard)).to(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        describe("tap action") {
            
            func action(for action: KeyboardAction) -> Any? {
                return handler.tapAction(for: action, sender: UIView())
            }
            
            it("is not nil for action types with standard action") {
                expect(action(for: .dismissKeyboard)).toNot(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        
        // MARK: - Action Handling
        
        describe("handling gesture on action") {
            
            it("TODO") {}
        }
        
        
        // MARK: - Haptic Feedback
        
        describe("giving haptic feedback") {
            
            it("can't be properyly tested") {
                handler.triggerHapticFeedback(for: .longPress, on: .dismissKeyboard)
                handler.triggerHapticFeedback(for: .repeatPress, on: .backspace)
                handler.triggerHapticFeedback(for: .tap, on: .dismissKeyboard)
                // TODO Test this
            }
        }
        
        
        // MARK: - Audio Feedback
        
        describe("giving haptic feedback for long press") {
            
            it("can't be properyly tested") {
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .backspace, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                // TODO Test this
            }
        }
    }
}


private class StandardKeyboardActionHandlerTestClass: StandardKeyboardActionHandler {
    
    public init(
        recorder: MockKeyboardActionHandler,
        inputViewController: UIInputViewController) {
        self.recorder = recorder
        super.init(inputViewController: inputViewController)
    }
    
    let recorder: MockKeyboardActionHandler
    
    override func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        switch gesture {
        case .doubleTap: recorder.giveHapticFeedbackForDoubleTap(on: action)
        case .longPress: recorder.giveHapticFeedbackForLongPress(on: action)
        case .repeatPress: recorder.giveHapticFeedbackForRepeat(on: action)
        case .tap: recorder.giveHapticFeedbackForTap(on: action)
        }
    }
}
