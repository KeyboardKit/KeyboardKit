//
//  KeyboardAction+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI
import UIKit

class KeyboardAction_SystemTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        var context: KeyboardContext!
        
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
            context = MockKeyboardContext()
            expected = []
            unexpected = []
        }
        
        describe("standard button background color") {
            
            func result(for action: KeyboardAction) -> Color {
                action.standardButtonBackgroundColor(for: context)
            }
            
            it("is clear for some actions") {
                expected = [.none]
                expected.forEach { expect(result(for: $0)).to(equal(.clear)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.clear)) }
            }
            
            it("is clear interactable for some actions") {
                expected = [.emoji(Emoji("")), .emojiCategory(.smileys)]
                expected.forEach { expect(result(for: $0)).to(equal(.clearInteractable)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.clearInteractable)) }
            }
            
            it("is standrd for other actions (requires bundle to be loaded)") {
//                expected = [.none, .emoji(""), .emojiCategory(.smileys)]
//                unexpected.forEach {
//                    if ($0.isSystemAction) {
//                        expect(result(for: $0)).to(equal(.standardDarkButton(for: context)))
//                    } else {
//                        expect(result(for: $0)).to(equal(.standardDarkButton(for: context)))
//                    }
//                }
            }
        }
        
        describe("standard button image") {
            
            func result(for action: KeyboardAction) -> Image? {
                action.standardButtonImage
            }
            
            it("is defined for some actions") {
                expect(result(for: .backspace)).to(equal(.backspace))
                expect(result(for: .command)).to(equal(.command))
                expect(result(for: .control)).to(equal(.control))
                expect(result(for: .dictation)).to(equal(.dictation))
                expect(result(for: .dismissKeyboard)).to(equal(.keyboardDismiss))
                expect(result(for: .keyboardType(.email))).to(equal(.email))
                expect(result(for: .moveCursorBackward)).to(equal(.moveCursorLeft))
                expect(result(for: .moveCursorForward)).to(equal(.moveCursorRight))
                expect(result(for: .newLine)).to(equal(.newLine))
                expect(result(for: .nextKeyboard)).to(equal(.globe))
                expect(result(for: .option)).to(equal(.option))
                expect(result(for: .shift(currentState: .lowercased))).to(equal(.shiftLowercased))
                expect(result(for: .shift(currentState: .uppercased))).to(equal(.shiftUppercased))
                expect(result(for: .shift(currentState: .capsLocked))).to(equal(.shiftCapslocked))
                expect(result(for: .tab)).to(equal(.tab))
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .character(""))).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .emoji(Emoji("")))).to(beNil())
                expect(result(for: .emojiCategory(.activities))).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .space)).to(beNil())
            }
        }
        
        describe("standard button shadow color") {
            
            func result(for action: KeyboardAction) -> Color {
                action.standardButtonShadowColor(for: context)
            }
            
            it("is clear for emoji, not others") {
                expected = [.none, .emoji(Emoji(""))]
                expected.forEach { expect(result(for: $0)).to(equal(.clear)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.clear)) }
            }
        }
        
        describe("standard button font") {
            
            it("is defined for all actions") {
                actions.forEach {
                    expect($0.standardButtonFont).to(equal(UIFont.preferredFont(forTextStyle: $0.standardButtonTextStyle)))
                }
            }
        }
        
        describe("system button text") {
            
            func result(for action: KeyboardAction) -> String? {
                action.standardButtonText
            }
            
            it("is defined for some actions") {
                expect(result(for: .character("A"))).to(equal("A"))
                expect(result(for: .emoji(Emoji("🛸")))).to(equal("🛸"))
                expect(result(for: .emojiCategory(.animals))).to(equal("🐻"))
                
                expect(result(for: .keyboardType(.alphabetic(.capsLocked)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.lowercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.uppercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.numeric))).to(equal("123"))
                expect(result(for: .keyboardType(.symbolic))).to(equal("#+="))
                expect(result(for: .keyboardType(.custom("")))).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .keyboardType(.emojis))).to(equal("☺"))
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
        
        describe("standard button text style") {
            
            func getActions(_ actions: KeyboardAction...) -> [KeyboardAction] { actions }
            
            it("is custom for some actions, but defined for all") {
                let expectedTitle = getActions(.emoji(Emoji("")))
                let expectedCallout = getActions(.emojiCategory(.smileys))
                var expectedBody = actions.filter { $0.isSystemAction && $0.standardButtonText != nil }
                expectedBody.append(.character("abc"))
                
                actions.forEach {
                    if case .emoji = $0 {
                        expect($0.standardButtonTextStyle).to(equal(.title1))
                    } else if case .keyboardType(.emojis) = $0 {
                        expect($0.standardButtonTextStyle).to(equal(.title2))
                    } else if expectedTitle.contains($0) {
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
