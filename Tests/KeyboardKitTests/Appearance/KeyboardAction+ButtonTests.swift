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
            context = KeyboardContext(controller: MockKeyboardInputViewController())
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
            
            it("is blue for primary actions") {
                expected = [.done, .go, .ok, .search]
                expected.forEach { expect(result(for: $0)).to(equal(.blue)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.blue)) }
            }
            
            it("is standard for all other actions") {
                let nonStandard: [KeyboardAction] = [.none, .emoji(Emoji("")), .emojiCategory(.smileys), .done, .go, .ok, .search]
                expected = actions.filter { !nonStandard.contains($0) }
                expected.forEach {
                    if $0.isSystemAction {
                        expect(result(for: $0)).to(equal(Color.standardDarkButton(for: context)))
                    } else {
                        expect(result(for: $0)).to(equal(Color.standardButton(for: context)))
                    }
                }
            }
        }
        
        describe("standard button image") {
            
            func result(for action: KeyboardAction) -> Image? {
                action.standardButtonImage
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .command,
                    .control,
                    .dictation,
                    .dismissKeyboard,
                    .image(description: "", keyboardImageName: "", imageName: ""),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextKeyboard,
                    .option,
                    .settings,
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased),
                    .shift(currentState: .capsLocked),
                    .systemImage(description: "", keyboardImageName: "", imageName: ""),
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard button font") {
            
            func result(for action: KeyboardAction) -> UIFont {
                action.standardButtonFont(for: context)
            }
            
            it("is defined for all actions") {
                actions.forEach {
                    let expected = UIFont.preferredFont(forTextStyle: $0.standardButtonTextStyle(for: context))
                    expect(result(for: $0)).to(equal(expected))
                }
            }
        }
        
        describe("standard button font weight") {
            
            func result(for action: KeyboardAction) -> UIFont.Weight? {
                action.standardButtonFontWeight
            }
            
            it("is light for actions with image and lower cased char") {
                expect(result(for: .character("A"))).to(beNil())
                expect(result(for: .character("a"))).to(equal(.light))
                expect(result(for: .backspace)).to(equal(.light))
            }
        }
        
        describe("standard button foreground color") {
            
            func result(for action: KeyboardAction) -> Color {
                action.standardButtonForegroundColor(for: context)
            }
            
            it("is white for primary actions") {
                expected = [.done, .go, .ok, .search]
                expected.forEach { expect(result(for: $0)).to(equal(.white)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.white)) }
            }
            
            it("is standard for all other actions") {
                let nonStandard: [KeyboardAction] = [.done, .go, .ok, .search]
                expected = actions.filter { !nonStandard.contains($0) }
                expected.forEach {
                    expect(result(for: $0)).to(equal(Color.standardButtonTint(for: context)))
                }
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
        
        describe("standard button text") {
            
            func result(for action: KeyboardAction) -> String? {
                action.standardButtonText(for: context)
            }
            
            it("is defined for some actions") {
                expect(result(for: .character("A"))).to(equal("A"))
                expect(result(for: .emoji(Emoji("🛸")))).to(equal("🛸"))
                expect(result(for: .emojiCategory(.animals))).to(equal("🐻"))
                
                expect(result(for: .keyboardType(.alphabetic(.capsLocked)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.lowercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.uppercased)))).to(equal("ABC"))
                expect(result(for: .go)).to(equal("-"))
                expect(result(for: .keyboardType(.numeric))).to(equal("123"))
                expect(result(for: .keyboardType(.symbolic))).to(equal("#+="))
                expect(result(for: .keyboardType(.custom("")))).to(beNil())
                expect(result(for: .nextLocale)).to(equal("en"))
                expect(result(for: .ok)).to(equal("OK"))
                expect(result(for: .return)).to(equal("-"))
                expect(result(for: .search)).to(equal("-"))
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .backspace)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .control)).to(beNil())
                expect(result(for: .custom(name: ""))).to(beNil())
                expect(result(for: .dictation)).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .keyboardType(.images))).to(beNil())
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
            
            func result(for action: KeyboardAction) -> UIFont.TextStyle {
                action.standardButtonTextStyle(for: context)
            }
            
            it("is custom for some actions, but defined for all") {
                let expectedTitle = getActions(.emoji(Emoji("")))
                let expectedCallout = getActions(.emojiCategory(.smileys))
                var expectedBody = actions.filter { $0 == .space || ($0.isSystemAction && $0.standardButtonText(for: context) != nil) }
                expectedBody.append(.character("abc"))
                expectedBody.append(.go)
                expectedBody.append(.ok)
                expectedBody.append(.return)
                expectedBody.append(.search)
                
                actions.forEach {
                    if case .emoji = $0 {
                        expect(result(for: $0)).to(equal(.title1))
                    } else if case .keyboardType(.emojis) = $0 {
                        expect(result(for: $0)).to(equal(.title2))
                    } else if expectedTitle.contains($0) {
                        expect(result(for: $0)).to(equal(.title1))
                    } else if expectedCallout.contains($0) {
                        expect(result(for: $0)).to(equal(.callout))
                    } else if expectedBody.contains($0) {
                        expect(result(for: $0)).to(equal(.body))
                    } else {
                        expect(result(for: $0)).to(equal(.title2))
                    }
                }
            }
            
            it("uses different font for lower and uppercased chars") {
                expect(result(for: KeyboardAction.character("a"))).to(equal(.title1))
                expect(result(for: KeyboardAction.character("A"))).to(equal(.title2))
            }
        }
    }
}
