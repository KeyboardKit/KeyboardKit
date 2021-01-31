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
        
        describe("standard double tap action") {
            
            it("is not defined for any actions") {
                expected = []
                expected.forEach { expect($0.standardDoubleTapAction).toNot(beNil()) }
                unexpected.forEach { expect($0.standardDoubleTapAction).to(beNil()) }
            }
        }
        
        describe("standard long press action") {
            
            it("is defined for some actions") {
                expected = [.backspace]
                expected.forEach { expect($0.standardLongPressAction).toNot(beNil()) }
                unexpected.forEach { expect($0.standardLongPressAction).to(beNil()) }
            }
        }
        
        describe("standard tap action") {
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .character(""),
                    .dismissKeyboard,
                    .emoji(Emoji("")),
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
                expected.forEach { expect($0.standardTapAction).toNot(beNil()) }
                unexpected.forEach { expect($0.standardTapAction).to(beNil()) }
            }
        }
        
        describe("standard repeat action") {
            
            it("is defined for some actions") {
                expected = [.backspace]
                expected.forEach { expect($0.standardRepeatAction).toNot(beNil()) }
                unexpected.forEach { expect($0.standardRepeatAction).to(beNil()) }
            }
        }
    }
}
