//
//  KeyboardActionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

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
        
        describe("is character action") {
            
            func result(for action: KeyboardAction) -> Bool {
                action.isCharacterAction
            }
            
            it("is only true for character actions") {
                expected = [.character("")]
                expected.forEach { expect($0.isCharacterAction).to(beTrue()) }
                unexpected.forEach { expect($0.isCharacterAction).to(beFalse()) }
            }
        }
        
        describe("is input action") {
            
            it("is true for some actions") {
                expected = [
                    .character(""),
                    .characterMargin(""),
                    .emoji(Emoji("")),
                    .image(description: "", keyboardImageName: "", imageName: ""),
                    .space,
                    .systemImage(description: "", keyboardImageName: "", imageName: "")]
                expected.forEach { expect($0.isInputAction).to(beTrue()) }
                unexpected.forEach { expect($0.isInputAction).to(beFalse()) }
            }
        }
        
        describe("is primary action") {
            
            it("is true for some actions") {
                expected = [.primary(.done), .primary(.go), .primary(.newLine), .primary(.ok), .primary(.search)]
                expected.forEach { expect($0.isPrimaryAction).to(beTrue()) }
                unexpected.forEach { expect($0.isPrimaryAction).to(beFalse()) }
            }
        }
        
        describe("is shift") {
            
            it("is only true for all shift actions") {
                expected = [
                    .shift(currentState: .capsLocked),
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased)]
                expected.forEach { expect($0.isShift).to(beTrue()) }
                unexpected.forEach { expect($0.isShift).to(beFalse()) }
            }
        }
        
        describe("is space") {
            
            it("is only true for all space actions") {
                expected = [.space, .character(" ")]
                expected.forEach { expect($0.isSpace).to(beTrue()) }
                unexpected.forEach { expect($0.isSpace).to(beFalse()) }
            }
        }
        
        describe("is system action") {
            
            it("is true for some actions") {
                expected = [
                    .backspace,
                    .command,
                    .control,
                    .dictation,
                    .dismissKeyboard,
                    .emojiCategory(.smileys),
                    .escape,
                    .function,
                    .keyboardType(.alphabetic(.lowercased)),
                    .keyboardType(.alphabetic(.uppercased)),
                    .keyboardType(.alphabetic(.capsLocked)),
                    .keyboardType(.numeric),
                    .keyboardType(.symbolic),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .keyboardType(.custom(named: "")),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextLocale,
                    .nextKeyboard,
                    .option,
                    .return,
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased),
                    .shift(currentState: .capsLocked),
                    .tab
                ]
                expected.forEach { expect($0.isSystemAction).to(beTrue()) }
                unexpected.forEach { expect($0.isSystemAction).to(beFalse()) }
            }
        }
        
        describe("is uppercase shift") {
            
            it("is only true for uppercase shift actions") {
                expected = [
                    .shift(currentState: .capsLocked),
                    .shift(currentState: .uppercased)]
                expected.forEach { expect($0.isUppercaseShift).to(beTrue()) }
                unexpected.forEach { expect($0.isUppercaseShift).to(beFalse()) }
            }
        }
    }
}
