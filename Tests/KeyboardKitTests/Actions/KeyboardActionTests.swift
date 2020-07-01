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

extension KeyboardAction {
    
    static var testActions: [KeyboardAction] {
        [
            .none,
            .dismissKeyboard,
            .capsLock,
            .character(""),
            .command,
            .control,
            .custom(name: ""),
            .dictation,
            .escape,
            .emoji(""),
            .emojiCategory(.smileys),
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
    }
}

class KeyboardActionTests: QuickSpec {
    
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
                    .capsLock,
                    .command,
                    .dictation,
                    .dismissKeyboard,
                    .emojiCategory(.smileys),
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
    }
}
