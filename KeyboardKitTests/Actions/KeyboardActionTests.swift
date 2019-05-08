//
//  KeyboardActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        describe("action type") {
            
            it("is input view controller action if vc should handle it") {
                
                func result(for action: KeyboardAction) -> Bool {
                    return action.isInputViewControllerAction
                }
                
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beFalse())
                expect(result(for: .character("a"))).to(beFalse())
                expect(result(for: .dismissKeyboard)).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .moveCursorBack)).to(beFalse())
                expect(result(for: .moveCursorForward)).to(beFalse())
                expect(result(for: .newLine)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .space)).to(beFalse())
                expect(result(for: .switchKeyboard)).to(beTrue())
            }
            
            it("is text document proxy action if proxy should handle it") {
                
                func result(for action: KeyboardAction) -> Bool {
                    return action.isTextDocumentProyAction
                }
                
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .character("a"))).to(beTrue())
                expect(result(for: .dismissKeyboard)).to(beFalse())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .moveCursorBack)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .shift)).to(beTrue())
                expect(result(for: .space)).to(beTrue())
                expect(result(for: .switchKeyboard)).to(beFalse())
                
            }
        }
    }
}
