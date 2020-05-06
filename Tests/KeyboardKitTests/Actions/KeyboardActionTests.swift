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
            
            it("is true for content actions") {
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beTrue())
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
            
            it("is true for content actions") {
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beFalse())
                expect(result(for: .dismissKeyboard)).to(beFalse())
                expect(result(for: .capsLock)).to(beFalse())
                expect(result(for: .character(""))).to(beTrue())
                expect(result(for: .command)).to(beFalse())
                expect(result(for: .custom(name: ""))).to(beFalse())
                expect(result(for: .escape)).to(beFalse())
                expect(result(for: .function)).to(beFalse())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beTrue())
                expect(result(for: .keyboardType(.email))).to(beFalse())
                expect(result(for: .moveCursorBackward)).to(beFalse())
                expect(result(for: .moveCursorForward)).to(beFalse())
                expect(result(for: .newLine)).to(beFalse())
                expect(result(for: .nextKeyboard)).to(beFalse())
                expect(result(for: .option)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .shiftDown)).to(beFalse())
                expect(result(for: .space)).to(beTrue())
                expect(result(for: .tab)).to(beFalse())
            }
        }
        
        describe("is system action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isSystemAction
            }
            
            it("is true for content actions") {
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .dismissKeyboard)).to(beTrue())
                expect(result(for: .capsLock)).to(beTrue())
                expect(result(for: .character(""))).to(beFalse())
                expect(result(for: .command)).to(beTrue())
                expect(result(for: .custom(name: ""))).to(beFalse())
                expect(result(for: .emojiCategory(.foods))).to(beFalse())
                expect(result(for: .escape)).to(beTrue())
                expect(result(for: .function)).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .keyboardType(.email))).to(beTrue())
                expect(result(for: .moveCursorBackward)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .nextKeyboard)).to(beTrue())
                expect(result(for: .option)).to(beTrue())
                expect(result(for: .shift)).to(beTrue())
                expect(result(for: .shiftDown)).to(beTrue())
                expect(result(for: .space)).to(beFalse())
                expect(result(for: .tab)).to(beTrue())
            }
        }
        
        describe("standard input view controller action") {
            
            func action(for action: KeyboardAction) -> ((KeyboardInputViewController?) -> Void)? {
                return action.standardInputViewControllerAction
            }
            
            it("is defined for some actions") {
                expect(action(for: .dismissKeyboard)).toNot(beNil())
                expect(action(for: .keyboardType(.email))).toNot(beNil())
                expect(action(for: .shift)).toNot(beNil())
                expect(action(for: .shiftDown)).toNot(beNil())
                
                expect(action(for: .none)).to(beNil())
                expect(action(for: .backspace)).to(beNil())
                expect(action(for: .capsLock)).to(beNil())
                expect(action(for: .character(""))).to(beNil())
                expect(action(for: .command)).to(beNil())
                expect(action(for: .custom(name: ""))).to(beNil())
                expect(action(for: .escape)).to(beNil())
                expect(action(for: .function)).to(beNil())
                expect(action(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(action(for: .moveCursorBackward)).to(beNil())
                expect(action(for: .moveCursorForward)).to(beNil())
                expect(action(for: .newLine)).to(beNil())
                expect(action(for: .nextKeyboard)).to(beNil())
                expect(action(for: .option)).to(beNil())
                expect(action(for: .space)).to(beNil())
                expect(action(for: .tab)).to(beNil())
            }
        }
        
        describe("standard text document proxy action") {
            
            func action(for action: KeyboardAction) -> ((UITextDocumentProxy?) -> Void)? {
                return action.standardTextDocumentProxyAction
            }
            
            it("is defined for some actions") {
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .character("a"))).toNot(beNil())
                expect(action(for: .moveCursorBackward)).toNot(beNil())
                expect(action(for: .moveCursorForward)).toNot(beNil())
                expect(action(for: .newLine)).toNot(beNil())
                expect(action(for: .space)).toNot(beNil())
                expect(action(for: .tab)).toNot(beNil())
                
                expect(action(for: .none)).to(beNil())
                expect(action(for: .dismissKeyboard)).to(beNil())
                expect(action(for: .capsLock)).to(beNil())
                expect(action(for: .command)).to(beNil())
                expect(action(for: .custom(name: ""))).to(beNil())
                expect(action(for: .escape)).to(beNil())
                expect(action(for: .function)).to(beNil())
                expect(action(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(action(for: .keyboardType(.email))).to(beNil())
                expect(action(for: .nextKeyboard)).to(beNil())
                expect(action(for: .option)).to(beNil())
                expect(action(for: .shift)).to(beNil())
                expect(action(for: .shiftDown)).to(beNil())
            }
        }
    }
}
