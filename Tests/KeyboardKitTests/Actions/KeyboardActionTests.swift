//
//  KeyboardActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        var actions: [KeyboardAction]!
        
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
            actions = [
                .none,
                .dismissKeyboard,
                .capsLock,
                .character(""),
                .command,
                .custom(name: ""),
                .escape,
                .function,
                .image(description: "", keyboardImageName: "", imageName: ""),
                .keyboardType(.email),
                .moveCursorBackward,
                .moveCursorForward,
                .newLine,
                .nextKeyboard,
                .option,
                .shift,
                .shiftDown,
                .space,
                .systemImage(description: "", keyboardImageName: "", imageName: ""),
                .tab
            ]
            
            expected = []
            unexpected = []
        }
        
        describe("is delete action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isDeleteAction
            }
            
            it("is true for some actions") {
                expected = [.backspace]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
        
        describe("is input action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isInputAction
            }
            
            it("is true for some actions") {
                expected = [
                    .character(""),
                    .emoji(""),
                    .image(description: "", keyboardImageName: "", imageName: ""),
                    .space,
                    .systemImage(description: "", keyboardImageName: "", imageName: "")
                ]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
        
        describe("is system action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isSystemAction
            }
            
            it("is true for some actions") {
                expected = [
                    .backspace,
                    .dismissKeyboard,
                    .capsLock,
                    .command,
                    .escape,
                    .function,
                    .keyboardType(.email),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextKeyboard,
                    .option,
                    .shift,
                    .shiftDown,
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).to(beTrue()) }
                unexpected.forEach { expect(result(for: $0)).to(beFalse()) }
            }
        }
        
        describe("standard double tap action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
                action.standardDoubleTapAction
            }
            
            it("is defined for some actions") {
                expected = [.shift, .space]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard long press action") {
            
            func result(for action: KeyboardAction) -> Bool {
                if action.standardTapAction != nil { return action.standardLongPressAction != nil }
                return action.standardLongPressAction == nil
            }
            
            it("is defined for all actions that has a standard tap action") {
                actions.forEach { expect(result(for: $0)).to(beTrue()) }
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
                    .keyboardType(.email),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .shift,
                    .shiftDown,
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
        
        describe("system font") {
            
            it("is defined for all actions") {
                actions.forEach {
                    expect($0.systemFont).to(equal(UIFont.preferredFont(forTextStyle: $0.systemTextStyle)))
                }
            }
        }
        
        describe("system text style") {
            
            it("is custom for some actions, but defined for all") {
                actions.forEach {
                    if $0 == .emoji("") {
                        expect($0.systemTextStyle).to(equal(.title1))
                    } else {
                        expect($0.systemTextStyle).to(equal(.title2))
                    }
                }
            }
        }
    }
}
