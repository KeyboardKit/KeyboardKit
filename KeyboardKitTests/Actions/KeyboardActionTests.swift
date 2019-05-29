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

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        describe("standard input view controller action") {
            
            func action(for action: KeyboardAction) -> ((UIInputViewController?) -> ())? {
                return action.standardInputViewControllerAction
            }
            
            it("is defined for some actions") {
                expect(action(for: .none)).to(beNil())
                expect(action(for: .backspace)).to(beNil())
                expect(action(for: .dismissKeyboard)).toNot(beNil())
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
                expect(action(for: .option)).to(beNil())
                expect(action(for: .shift)).to(beNil())
                expect(action(for: .shiftDown)).to(beNil())
                expect(action(for: .space)).to(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
                expect(action(for: .switchToKeyboard(.email))).to(beNil())
                expect(action(for: .tab)).to(beNil())
            }
        }
        
        describe("standard text document proxy action") {
            
            func action(for action: KeyboardAction) -> ((UITextDocumentProxy?) -> ())? {
                return action.standardTextDocumentProxyAction
            }
            
            it("is defined for some actions") {
                expect(action(for: .none)).to(beNil())
                expect(action(for: .backspace)).toNot(beNil())
                expect(action(for: .dismissKeyboard)).to(beNil())
                expect(action(for: .capsLock)).to(beNil())
                expect(action(for: .character("a"))).toNot(beNil())
                expect(action(for: .command)).to(beNil())
                expect(action(for: .custom(name: ""))).to(beNil())
                expect(action(for: .escape)).to(beNil())
                expect(action(for: .function)).to(beNil())
                expect(action(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beNil())
                expect(action(for: .moveCursorBackward)).toNot(beNil())
                expect(action(for: .moveCursorForward)).toNot(beNil())
                expect(action(for: .newLine)).toNot(beNil())
                expect(action(for: .option)).to(beNil())
                expect(action(for: .shift)).to(beNil())
                expect(action(for: .shiftDown)).to(beNil())
                expect(action(for: .space)).toNot(beNil())
                expect(action(for: .switchKeyboard)).to(beNil())
                expect(action(for: .switchToKeyboard(.email))).to(beNil())
                expect(action(for: .tab)).toNot(beNil())
            }
        }
    }
}
