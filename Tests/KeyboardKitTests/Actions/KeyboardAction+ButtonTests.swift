//
//  KeyboardAction+SystemTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardAction_SystemTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        
        describe("system font") {
            
            it("is defined for all actions") {
                actions.forEach {
                    expect($0.standardButtonFont).to(equal(UIFont.preferredFont(forTextStyle: $0.standardButtonTextStyle)))
                }
            }
        }
        
        describe("system keyboard button text") {
            
            func result(for action: KeyboardAction) -> String? {
                action.standardButtonText
            }
            
            it("is defined for some actions") {
                expect(result(for: .character("A"))).to(equal("A"))
                expect(result(for: .emoji("🛸"))).to(equal("🛸"))
                expect(result(for: .emojiCategory(.animals))).to(equal("🐻"))
                
                expect(result(for: .keyboardType(.alphabetic(.capsLocked)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.lowercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.uppercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.numeric))).to(equal("123"))
                expect(result(for: .keyboardType(.symbolic))).to(equal("#+="))
                expect(result(for: .keyboardType(.custom("")))).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .keyboardType(.emojis))).to(beNil())
                expect(result(for: .keyboardType(.images))).to(beNil())
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .backspace)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .control)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .dictation)).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .moveCursorBackward)).to(beNil())
                expect(result(for: .moveCursorForward)).to(beNil())
                expect(result(for: .newLine)).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
                expect(result(for: .shift(currentState: .lowercased))).to(beNil())
                expect(result(for: .shift(currentState: .uppercased))).to(beNil())
                expect(result(for: .shift(currentState: .capsLocked))).to(beNil())
                expect(result(for: .space)).to(beNil())
                expect(result(for: .tab)).to(beNil())
            }
        }
        
        describe("system text style") {
            
            func getActions(_ actions: KeyboardAction...) -> [KeyboardAction] { actions }
            
            it("is custom for some actions, but defined for all") {
                let expectedTitle = getActions(.emoji(""))
                let expectedCallout = getActions(.emojiCategory(.smileys))
                var expectedBody = actions.filter { $0.isSystemAction && $0.standardButtonText != nil }
                expectedBody.append(.character("abc"))
                
                actions.forEach {
                    if expectedTitle.contains($0) {
                        expect($0.standardButtonTextStyle).to(equal(.title1))
                    } else if expectedCallout.contains($0) {
                        expect($0.standardButtonTextStyle).to(equal(.callout))
                    } else if expectedBody.contains($0) {
                        expect($0.standardButtonTextStyle).to(equal(.body))
                    } else {
                        expect($0.standardButtonTextStyle).to(equal(.title2))
                    }
                }
            }
        }
    }
}
