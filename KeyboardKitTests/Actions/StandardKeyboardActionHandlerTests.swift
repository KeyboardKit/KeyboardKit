//
//  StandardKeyboardActionHandlerTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockNRoll
import KeyboardKit

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
                return handler.longPressAction(for: action, view: UIView())
            }
            
            it("is by default the tap action") {
                expect(action(for: .dismissKeyboard)).toNot(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        describe("repeat action") {
            
            func action(for action: KeyboardAction) -> Any? {
                return handler.repeatAction(for: action, view: UIView())
            }
            
            it("is only applied to backspace") {
                expect(action(for: .dismissKeyboard)).to(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        describe("tap action") {
            
            func action(for action: KeyboardAction) -> Any? {
                return handler.tapAction(for: action, view: UIView())
            }
            
            it("is not nil for action types with standard action") {
                expect(action(for: .dismissKeyboard)).toNot(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
            }
        }
        
        
        // MARK: - Action Handling
        
        describe("handling long press") {
            
            it("is performed for any action type with tap action") {
                handler.handleLongPress(on: .dismissKeyboard, view: UIView())
                handler.handleLongPress(on: .backspace, view: UIView())
                handler.handleLongPress(on: .switchKeyboard, view: UIView())
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForLongPress)
                expect(invokes.count).to(equal(2))
            }
        }
        
        describe("handling repeat") {
            
            it("is performed for any action type with repeat action") {
                handler.handleRepeat(on: .dismissKeyboard, view: UIView())
                handler.handleRepeat(on: .backspace, view: UIView())
                handler.handleRepeat(on: .switchKeyboard, view: UIView())
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForRepeat)
                expect(invokes.count).to(equal(1))
            }
        }
        
        describe("tap handling") {
            
            it("is performed for action type with standard input view controller action") {
                handler.handleTap(on: .dismissKeyboard, view: UIView())
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForTap)
                expect(invokes.count).to(equal(1))
                expect(invokes[0].arguments).to(equal(.dismissKeyboard))
            }
            
            it("is performed for action type with standard text document proxy action") {
                handler.handleTap(on: .backspace, view: UIView())
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForTap)
                expect(invokes.count).to(equal(1))
                expect(invokes[0].arguments).to(equal(.backspace))
            }
            
            it("is not performed for action type without standard action") {
                handler.handleTap(on: .switchKeyboard, view: UIView())
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForTap)
                expect(invokes.count).to(equal(0))
            }
        }
        
        
        // MARK: - Haptic Functions
        
        describe("giving haptic feedback for long press") {
            
            it("can't be properyly tested") {
                handler.giveHapticFeedbackForLongPress(on: .dismissKeyboard)
                // Test this
            }
        }
        
        describe("giving haptic feedback for repeat") {
            
            it("can't be properyly tested") {
                handler.giveHapticFeedbackForRepeat(on: .backspace)
                // Test this
            }
        }
        
        describe("giving haptic feedback for tap") {
            
            it("can't be properyly tested") {
                handler.giveHapticFeedbackForTap(on: .dismissKeyboard)
                // Test this
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
    
    
    override func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        recorder.giveHapticFeedbackForLongPress(on: action)
    }

    override func giveHapticFeedbackForRepeat(on action: KeyboardAction) {
        recorder.giveHapticFeedbackForRepeat(on: action)
    }
    
    override func giveHapticFeedbackForTap(on action: KeyboardAction) {
        recorder.giveHapticFeedbackForTap(on: action)
    }
}
