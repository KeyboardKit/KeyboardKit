//
//  KeyboardActionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardActionTests: XCTestCase {

    let actions = KeyboardAction.testActions

    var expected: [KeyboardAction]! {
        didSet { unexpected = actions.filter { !expected.contains($0) } }
    }

    var unexpected: [KeyboardAction]!

    override func setUp() {
        expected = []
        unexpected = []
    }

    func testIsCharacterActionIsTrueForCharacterActions() {
        actions.forEach { action in
            let result = action.isCharacterAction
            switch action {
            case .character: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsInputActionIsTrueForSomeActions() {
        actions.forEach { action in
            let result = action.isInputAction
            switch action {
            case .character: XCTAssertTrue(result)
            case .characterMargin: XCTAssertTrue(result)
            case .emoji: XCTAssertTrue(result)
            case .image: XCTAssertTrue(result)
            case .space: XCTAssertTrue(result)
            case .systemImage: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsPrimaryActionIsTrueForCharacterActions() {
        actions.forEach { action in
            let result = action.isPrimaryAction
            switch action {
            case .primary: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsShiftActionIsTrueForCharacterActions() {
        actions.forEach { action in
            let result = action.isShiftAction
            switch action {
            case .shift: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsSpacerIsTrueForSomeActions() {
        actions.forEach { action in
            let result = action.isSpacer
            switch action {
            case .characterMargin(""): XCTAssertTrue(result)
            case .none: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsSystemActionIsTrueForCharacterActions() {
        actions.forEach { action in
            let result = action.isSystemAction
            switch action {
            case .backspace: XCTAssertTrue(result)
            case .command: XCTAssertTrue(result)
            case .control: XCTAssertTrue(result)
            case .dictation: XCTAssertTrue(result)
            case .dismissKeyboard: XCTAssertTrue(result)
            case .emojiCategory: XCTAssertTrue(result)
            case .escape: XCTAssertTrue(result)
            case .function: XCTAssertTrue(result)
            case .keyboardType: XCTAssertTrue(result)
            case .moveCursorBackward: XCTAssertTrue(result)
            case .moveCursorForward: XCTAssertTrue(result)
            case .newLine: XCTAssertTrue(result)
            case .nextLocale: XCTAssertTrue(result)
            case .nextKeyboard: XCTAssertTrue(result)
            case .option: XCTAssertTrue(result)
            case .primary(.return): XCTAssertTrue(result)
            case .primary(.newLine): XCTAssertTrue(result)
            case .return: XCTAssertTrue(result)
            case .shift: XCTAssertTrue(result)
            case .tab: XCTAssertTrue(result)
            default: XCTAssertFalse(result)
            }
        }
    }

    func testIsUppercasedShiftActionIsTrueForCharacterActions() {
        actions.forEach { action in
            let result = action.isUppercasedShiftAction
            switch action {
            case .shift(let state): XCTAssertEqual(result, state.isUppercased)
            default: XCTAssertFalse(result)
            }
        }
    }
}
