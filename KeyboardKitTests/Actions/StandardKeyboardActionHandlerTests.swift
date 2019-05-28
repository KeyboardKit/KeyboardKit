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
        
        var actionsWithTap: [KeyboardAction] {
            return [
                .backspace, .dismissKeyboard, .character(""),
                .moveCursorBackward, .moveCursorForward,
                .newLine, .space
            ]
        }
        
        var actionsWithoutTap: [KeyboardAction] {
            return [
                .none, .image(description: "", keyboardImageName: "", imageName: ""),
                .switchKeyboard, .shift
            ]
        }
        
        var actionsWithLongPress: [KeyboardAction] {
            return []
        }
        
        var actionsWithoutLongPress: [KeyboardAction] {
            return [
                .none, .backspace, .dismissKeyboard, .character(""),
                .image(description: "", keyboardImageName: "", imageName: ""),
                .moveCursorBackward, .moveCursorForward,
                .switchKeyboard, .newLine, .shift, .space
            ]
        }
        
        beforeEach {
            recorder = MockKeyboardActionHandler()
            inputViewController = MockInputViewController()
            handler = StandardKeyboardActionHandlerTestClass(
                recorder: recorder,
                inputViewController: inputViewController,
                tapHapticFeedback: .error,
                longPressHapticFeedback: .warning)
        }
        
        
        
        
        describe("handling tap") {
            
            it("aborts if no action block is provided") {
                actionsWithoutTap.forEach {
                    handler.handleTap(on: $0, view: UIView())
                }
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForTap)
                expect(invokes.count).to(equal(0))
            }
            
            it("proceeds if an action block is provided") {
                actionsWithTap.forEach {
                    handler.handleTap(on: $0, view: UIView())
                }
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForTap)
                let args = invokes.map { $0.arguments }
                expect(invokes.count).to(beGreaterThan(0))
                expect(invokes.count).to(equal(actionsWithTap.count))
                expect(args).to(equal(actionsWithTap))
            }
        }
        
        describe("handling long press") {
            
            it("aborts if no action block is provided") {
                actionsWithoutLongPress.forEach {
                    handler.handleLongPress(on: $0, view: UIView())
                }
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForLongPress)
                expect(invokes.count).to(equal(0))
            }
            
            it("proceeds if an action block is provided") {
                actionsWithLongPress.forEach {
                    handler.handleLongPress(on: $0, view: UIView())
                }
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForLongPress)
                let args = invokes.map { $0.arguments }
                expect(invokes.count).to(equal(actionsWithLongPress.count))
                expect(args).to(equal(actionsWithLongPress))
            }
        }
        
        
        describe("giving haptic feedback for tap") {
            
            it("can't be properyly tested") {
                handler.giveHapticFeedbackForLongPress(on: .dismissKeyboard)
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForLongPress)
                expect(invokes.count).to(equal(1))
                expect(invokes[0].arguments).to(equal(.dismissKeyboard))
            }
        }
        
        describe("giving haptic feedback for long press") {
            
            it("can't be properyly tested") {
                handler.giveHapticFeedbackForLongPress(on: .dismissKeyboard)
                let invokes = handler.recorder.executions(of: handler.recorder.giveHapticFeedbackForLongPress)
                expect(invokes.count).to(equal(1))
                expect(invokes[0].arguments).to(equal(.dismissKeyboard))
            }
        }
        
        
        describe("tap action") {
            
            it("is not nil for all action types with tap") {
                let keyboardActions = actionsWithTap
                let result = keyboardActions.map { handler.tapAction(for: UIView(frame: .zero), action: $0) }
                result.forEach {
                    expect($0).toNot(beNil())
                }
            }
            
            it("is nil for all action types without tap") {
                let keyboardActions = actionsWithoutTap
                let result = keyboardActions.map { handler.tapAction(for: UIView(frame: .zero), action: $0) }
                result.forEach {
                    expect($0).to(beNil())
                }
            }
        }
        
        describe("long press action") {
            
            it("is not nil for all action types with long press") {
                let keyboardActions = actionsWithLongPress
                let result = keyboardActions.map { handler.longPressAction(for: UIView(frame: .zero), action: $0) }
                result.forEach {
                    expect($0).toNot(beNil())
                }
            }
            
            it("is nil for all action types without long press") {
                let keyboardActions = actionsWithoutLongPress
                let result = keyboardActions.map { handler.longPressAction(for: UIView(frame: .zero), action: $0) }
                result.forEach {
                    expect($0).to(beNil())
                }
            }
        }
    }
}


private class StandardKeyboardActionHandlerTestClass: StandardKeyboardActionHandler {
    
    public init(
        recorder: MockKeyboardActionHandler,
        inputViewController: UIInputViewController,
        tapHapticFeedback: HapticFeedback = .none,
        longPressHapticFeedback: HapticFeedback = .none) {
        self.recorder = recorder
        super.init(
            inputViewController: inputViewController,
            tapHapticFeedback: tapHapticFeedback,
            longPressHapticFeedback: longPressHapticFeedback)
    }
    
    let recorder: MockKeyboardActionHandler
    
    override func giveHapticFeedbackForTap(on action: KeyboardAction) {
        recorder.giveHapticFeedbackForTap(on: action)
    }
    
    override func giveHapticFeedbackForLongPress(on action: KeyboardAction) {
        recorder.giveHapticFeedbackForLongPress(on: action)
    }
}
