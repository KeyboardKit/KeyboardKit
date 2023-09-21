//
//  KeyboardAction+ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_ActionsTests: XCTestCase {

    let actions = KeyboardAction.testActions

    var expected: [KeyboardAction]! {
        didSet { unexpected = actions.filter { !expected.contains($0) } }
    }

    var unexpected: [KeyboardAction]!

    override func setUp() {
        expected = []
        unexpected = []
    }

    func testStandardActionIsDefinedForActionsWithPressOrReleaseAction() {

        func result(for action: KeyboardAction) -> Bool {
            let hasResult = (action.standardAction != nil)
            let hasPress = (action.standardPressAction != nil)
            let hasRelease = (action.standardReleaseAction != nil)
            return hasResult == (hasPress || hasRelease)
        }

        actions.forEach {
            XCTAssertTrue(result(for: $0))
        }
    }

    func testStandardActionUsesStandardActionProperties() {

        func result(
            for action: KeyboardAction,
            gesture: Gestures.KeyboardGesture,
            expected: KeyboardAction.GestureAction?
        ) -> Bool {
            let result = action.standardAction(for: gesture)
            let lhs = result == nil
            let rhs = expected == nil
            return lhs == rhs
        }

        actions.forEach {
            XCTAssertTrue(result(for: $0, gesture: .doubleTap, expected: $0.standardDoubleTapAction))
            XCTAssertTrue(result(for: $0, gesture: .longPress, expected: $0.standardLongPressAction))
            XCTAssertTrue(result(for: $0, gesture: .press, expected: $0.standardPressAction))
            XCTAssertTrue(result(for: $0, gesture: .release, expected: $0.standardReleaseAction))
            XCTAssertTrue(result(for: $0, gesture: .repeatPress, expected: $0.standardRepeatAction))
        }
    }

    func testStandardActionPropertiesAreDefinedForSomeGestures() {
        var action: (KeyboardAction) -> KeyboardAction.GestureAction?

        action = { $0.standardDoubleTapAction }
        expected = []
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardLongPressAction }
        expected = [.space]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardPressAction }
        expected = [
            .backspace,
            .keyboardType(.alphabetic(.lowercased)),
            .keyboardType(.alphabetic(.uppercased)),
            .keyboardType(.alphabetic(.capsLocked)),
            .keyboardType(.numeric),
            .keyboardType(.symbolic),
            .keyboardType(.email),
            .keyboardType(.emojis),
            .keyboardType(.images),
            .keyboardType(.custom(named: ""))
        ]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardReleaseAction }
        expected = [
            .character(""),
            .characterMargin(""),
            .dictation,
            .dismissKeyboard,
            .emoji(Emoji("")),
            .moveCursorBackward,
            .moveCursorForward,
            .nextKeyboard,
            .nextLocale,
            .primary(.done),
            .primary(.go),
            .primary(.newLine),
            .primary(.ok),
            .primary(.search),
            .primary(.return),
            .shift(currentCasing: .lowercased),
            .shift(currentCasing: .uppercased),
            .shift(currentCasing: .capsLocked),
            .space,
            .systemSettings,
            .tab,
            .url(URL(string: ""))
        ]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardRepeatAction }
        expected = [.backspace]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }
    }
}
