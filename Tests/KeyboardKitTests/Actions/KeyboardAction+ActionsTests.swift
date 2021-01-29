//
//  KeyboardAction+ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

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
        
        describe("standard long press action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.standardLongPressAction != nil
            }
            
            it("is defined for some actions") {
                expected = [.backspace]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
        
        describe("standard tap action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
                action.standardTapAction
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .character(""),
                    .dismissKeyboard,
                    .emoji(""),
                    .keyboardType(.alphabetic(.lowercased)),
                    .keyboardType(.alphabetic(.uppercased)),
                    .keyboardType(.alphabetic(.capsLocked)),
                    .keyboardType(.numeric),
                    .keyboardType(.symbolic),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .keyboardType(.custom("")),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
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
        
        describe("standard repeat action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
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
