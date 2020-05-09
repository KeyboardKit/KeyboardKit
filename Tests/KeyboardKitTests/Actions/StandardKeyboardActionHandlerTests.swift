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
        
        
        
        // MARK: - Properties
        
        describe("should change to alphabetic lowercase after input") {
            
            func result(for type: KeyboardType) -> Bool {
                inputViewController.keyboardType = type
                return handler.shouldChangeToAlphabeticLowercase
            }
            
            it("is only true if current keyboard type is uppercase alpha") {
                expect(result(for: .alphabetic(.uppercased))).to(beTrue())
                expect(result(for: .alphabetic(.capsLocked))).to(beFalse())
                expect(result(for: .alphabetic(.lowercased))).to(beFalse())
                expect(result(for: .numeric)).to(beFalse())
                expect(result(for: .symbolic)).to(beFalse())
                expect(result(for: .email)).to(beFalse())
                expect(result(for: .emojis)).to(beFalse())
                expect(result(for: .images)).to(beFalse())
                expect(result(for: .custom(""))).to(beFalse())
            }
        }
        
        
        // MARK: - Actions
        
        context("actions") {
            
            let actions: [KeyboardAction] = [
                .none,
                .backspace,
                .capsLock,
                .character(""),
                .command,
                .custom(name: ""),
                .dismissKeyboard,
                .emoji(""),
                .emojiCategory(.foods),
                .escape,
                .function,
                .image(description: "", keyboardImageName: "", imageName: ""),
                .keyboardType(.emojis),
                .moveCursorBackward,
                .moveCursorForward,
                .newLine,
                .nextKeyboard,
                .option,
                .shift,
                .shiftDown,
                .space,
                .tab
            ]
            
            describe("tap action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.tapAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardTapAction == nil))
                    }
                }
            }
            
            describe("double tap action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.doubleTapAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardDoubleTapAction == nil))
                    }
                }
            }
            
            describe("long press action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.longPressAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardLongPressAction == nil))
                    }
                }
            }
            
            describe("repeat action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.repeatAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardRepeatAction == nil))
                    }
                }
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
        inputViewController: KeyboardInputViewController) {
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
