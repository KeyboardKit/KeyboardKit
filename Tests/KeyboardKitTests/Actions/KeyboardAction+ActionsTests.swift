//
//  KeyboardAction+ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Quick
import Nimble
import KeyboardKit

class KeyboardAction_ActionsTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        
        var expected: [KeyboardAction]! {
            didSet {
                unexpected = actions
                expected.forEach { action in
                    unexpected.removeAll { $0 == action }
                }
            }
        }
        
        var unexpected: [KeyboardAction]!
        
        beforeEach {
            expected = []
            unexpected = []
        }
        
        describe("standard action for gesture") {
            
            func result(for action: KeyboardAction, gesture: KeyboardGesture, expected: KeyboardAction.GestureAction?) -> Bool {
                let result = action.standardAction(for: gesture)
                let lhs = result == nil
                let rhs = expected == nil
                return lhs == rhs
            }
            
            func result(for action: KeyboardAction) -> Bool {
                return
                    result(for: action, gesture: .doubleTap, expected: action.standardDoubleTapAction) &&
                    result(for: action, gesture: .longPress, expected: action.standardLongPressAction) &&
                    result(for: action, gesture: .press, expected: action.standardPressAction) &&
                    result(for: action, gesture: .release, expected: action.standardReleaseAction) &&
                    result(for: action, gesture: .repeatPress, expected: action.standardRepeatAction) &&
                    result(for: action, gesture: .tap, expected: action.standardTapAction)
            }
            
            it("is not defined for any actions") {
                KeyboardAction.testActions.forEach { expect(result(for: $0)).to(beTrue()) }
            }
        }
        
        describe("standard double tap action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardDoubleTapAction
            }
            
            it("is not defined for any actions") {
                expected = []
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard long press action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardLongPressAction
            }
            
            it("is defined for some actions") {
                expected = [.backspace]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard press action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardPressAction
            }
            
            it("is not defined for any actions") {
                expected = [
                    .keyboardType(.alphabetic(.lowercased)),
                    .keyboardType(.alphabetic(.uppercased)),
                    .keyboardType(.alphabetic(.capsLocked)),
                    .keyboardType(.numeric),
                    .keyboardType(.symbolic),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .keyboardType(.custom(named: ""))
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard release action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardReleaseAction
            }
            
            it("is not defined for any actions") {
                expected = []
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard tap action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardTapAction
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .character(""),
                    .characterMargin(""),
                    .dismissKeyboard,
                    .emoji(Emoji("")),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextLocale,
                    .primary(.done),
                    .primary(.go),
                    .primary(.newLine),
                    .primary(.ok),
                    .primary(.search),
                    .return,
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased),
                    .shift(currentState: .capsLocked),
                    .space,
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard text document proxy action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardTextDocumentProxyAction
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .character(""),
                    .characterMargin(""),
                    .emoji(Emoji("")),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .primary(.done),
                    .primary(.go),
                    .primary(.newLine),
                    .primary(.ok),
                    .primary(.search),
                    .return,
                    .space,
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard text document proxy input action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardTextDocumentProxyInputAction
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .character(""),
                    .characterMargin(""),
                    .emoji(Emoji("")),
                    .newLine,
                    .primary(.done),
                    .primary(.go),
                    .primary(.newLine),
                    .primary(.ok),
                    .primary(.search),
                    .return,
                    .space,
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard repeat action") {
            
            func result(for action: KeyboardAction) -> Any? {
                action.standardRepeatAction
            }
            
            it("is defined for some actions") {
                expected = [.backspace]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
    }
}
#endif
