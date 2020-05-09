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
        
        describe("is delete action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isDeleteAction
            }
            
            it("is true for some actions") {
                expect(result(for: .backspace)).to(beTrue())
                
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .dismissKeyboard)).to(beFalse())
                expect(result(for: .capsLock)).to(beFalse())
                expect(result(for: .character(""))).to(beFalse())
                expect(result(for: .command)).to(beFalse())
                expect(result(for: .custom(name: ""))).to(beFalse())
                expect(result(for: .escape)).to(beFalse())
                expect(result(for: .function)).to(beFalse())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .keyboardType(.email))).to(beFalse())
                expect(result(for: .moveCursorBackward)).to(beFalse())
                expect(result(for: .moveCursorForward)).to(beFalse())
                expect(result(for: .newLine)).to(beFalse())
                expect(result(for: .nextKeyboard)).to(beFalse())
                expect(result(for: .option)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .shiftDown)).to(beFalse())
                expect(result(for: .space)).to(beFalse())
                expect(result(for: .tab)).to(beFalse())
            }
        }
        
        describe("is input action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isInputAction
            }
            
            it("is true for some actions") {
                expect(result(for: .character(""))).to(beTrue())
                expect(result(for: .emoji(""))).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beTrue())
                expect(result(for: .space)).to(beTrue())
                
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beFalse())
                expect(result(for: .dismissKeyboard)).to(beFalse())
                expect(result(for: .capsLock)).to(beFalse())
                expect(result(for: .command)).to(beFalse())
                expect(result(for: .custom(name: ""))).to(beFalse())
                expect(result(for: .emojiCategory(.activities))).to(beFalse())
                expect(result(for: .escape)).to(beFalse())
                expect(result(for: .function)).to(beFalse())
                expect(result(for: .keyboardType(.email))).to(beFalse())
                expect(result(for: .moveCursorBackward)).to(beFalse())
                expect(result(for: .moveCursorForward)).to(beFalse())
                expect(result(for: .newLine)).to(beFalse())
                expect(result(for: .nextKeyboard)).to(beFalse())
                expect(result(for: .option)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .shiftDown)).to(beFalse())
                expect(result(for: .tab)).to(beFalse())
            }
        }
        
        describe("is system action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isSystemAction
            }
            
            it("is true for some actions") {
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .dismissKeyboard)).to(beTrue())
                expect(result(for: .capsLock)).to(beTrue())
                expect(result(for: .command)).to(beTrue())
                expect(result(for: .escape)).to(beTrue())
                expect(result(for: .function)).to(beTrue())
                expect(result(for: .keyboardType(.email))).to(beTrue())
                expect(result(for: .moveCursorBackward)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .nextKeyboard)).to(beTrue())
                expect(result(for: .option)).to(beTrue())
                expect(result(for: .shift)).to(beTrue())
                expect(result(for: .shiftDown)).to(beTrue())
                expect(result(for: .tab)).to(beTrue())
                
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .character(""))).to(beFalse())
                expect(result(for: .custom(name: ""))).to(beFalse())
                expect(result(for: .emoji(""))).to(beFalse())
                expect(result(for: .emojiCategory(.foods))).to(beFalse())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .space)).to(beFalse())
            }
        }
        
        describe("standard double tap action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
                action.standardDoubleTapAction
            }
            
            it("is defined for some actions") {
                expect(result(for: .shift)).toNot(beNil())
                expect(result(for: .space)).toNot(beNil())
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .backspace)).to(beNil())
                expect(result(for: .capsLock)).to(beNil())
                expect(result(for: .character("a"))).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .emoji(""))).to(beNil())
                expect(result(for: .emojiCategory(.foods))).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .moveCursorBackward)).to(beNil())
                expect(result(for: .moveCursorForward)).to(beNil())
                expect(result(for: .newLine)).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
                expect(result(for: .shiftDown)).to(beNil())
                expect(result(for: .tab)).to(beNil())
            }
        }
        
        describe("standard long press action") {
            
            func result(for action: KeyboardAction) -> Bool {
                if action.standardTapAction != nil { return action.standardLongPressAction != nil }
                return action.standardLongPressAction == nil
            }
            
            it("is defined for all actions that has a standard tap action") {
                expect(result(for: .none)).to(beTrue())
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .capsLock)).to(beTrue())
                expect(result(for: .character("a"))).to(beTrue())
                expect(result(for: .dismissKeyboard)).to(beTrue())
                expect(result(for: .command)).to(beTrue())
                expect(result(for: .custom(name: ""))).to(beTrue())
                expect(result(for: .escape)).to(beTrue())
                expect(result(for: .function)).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beTrue())
                expect(result(for: .keyboardType(.email))).to(beTrue())
                expect(result(for: .moveCursorBackward)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .nextKeyboard)).to(beTrue())
                expect(result(for: .option)).to(beTrue())
                expect(result(for: .shift)).to(beTrue())
                expect(result(for: .shiftDown)).to(beTrue())
                expect(result(for: .space)).to(beTrue())
                expect(result(for: .tab)).to(beTrue())
            }
        }
        
        describe("standard tap action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
                action.standardTapAction
            }
            
            it("is defined for some actions") {
                expect(result(for: .backspace)).toNot(beNil())
                expect(result(for: .character("a"))).toNot(beNil())
                expect(result(for: .dismissKeyboard)).toNot(beNil())
                expect(result(for: .emoji(""))).toNot(beNil())
                expect(result(for: .keyboardType(.email))).toNot(beNil())
                expect(result(for: .moveCursorBackward)).toNot(beNil())
                expect(result(for: .moveCursorForward)).toNot(beNil())
                expect(result(for: .newLine)).toNot(beNil())
                expect(result(for: .shift)).toNot(beNil())
                expect(result(for: .shiftDown)).toNot(beNil())
                expect(result(for: .space)).toNot(beNil())
                expect(result(for: .tab)).toNot(beNil())
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .capsLock)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .emojiCategory(.foods))).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
            }
        }
        
        describe("standard repeat action") {
            
            func result(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
                action.standardRepeatAction
            }
            
            it("is defined for some actions") {
                expect(result(for: .backspace)).toNot(beNil())
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .capsLock)).to(beNil())
                expect(result(for: .character("a"))).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .emoji(""))).to(beNil())
                expect(result(for: .emojiCategory(.foods))).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .moveCursorBackward)).to(beNil())
                expect(result(for: .moveCursorForward)).to(beNil())
                expect(result(for: .newLine)).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
                expect(result(for: .shift)).to(beNil())
                expect(result(for: .shiftDown)).to(beNil())
                expect(result(for: .space)).to(beNil())
                expect(result(for: .tab)).to(beNil())
            }
        }
    }
}
