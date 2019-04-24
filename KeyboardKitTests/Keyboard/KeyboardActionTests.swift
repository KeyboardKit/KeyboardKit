//
//  KeyboardActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-04-22.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardActionTests: QuickSpec {
    
    override func spec() {
        
        describe("should repeat on long press") {
            
            func result(for action: KeyboardAction) -> Bool {
                return action.shouldRepeatOnLongPress
            }
            
            it("is only specified for certain actions") {
                expect(result(for: .none)).to(beFalse())
                expect(result(for: .backspace)).to(beTrue())
                expect(result(for: .character("a"))).to(beTrue())
                expect(result(for: .image(description: "", keyboardImageName: "", imageName: ""))).to(beFalse())
                expect(result(for: .moveCursorBack)).to(beTrue())
                expect(result(for: .moveCursorForward)).to(beTrue())
                expect(result(for: .newLine)).to(beTrue())
                expect(result(for: .nextKeyboard)).to(beFalse())
                expect(result(for: .shift)).to(beFalse())
                expect(result(for: .space)).to(beTrue())
            }
        }
    }
}
