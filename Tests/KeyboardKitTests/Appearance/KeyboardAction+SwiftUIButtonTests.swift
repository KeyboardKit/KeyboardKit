//
//  KeyboardAction+ButtonTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import SwiftUI
@testable import KeyboardKit

class KeyboardAction_ButtonTests: QuickSpec {

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
                expected = [.emoji(""), .emojiCategory(.smileys)]
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
                let controller = KeyboardInputViewController()
                return action.standardButtonImage(for: controller.context)
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
                expect(result(for: .emoji(""))).to(beNil())
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
                expected = [.none, .emoji("")]
                expected.forEach { expect(result(for: $0)).to(equal(.clear)) }
                unexpected.forEach { expect(result(for: $0)).toNot(equal(.clear)) }
            }
        }
    }
}
