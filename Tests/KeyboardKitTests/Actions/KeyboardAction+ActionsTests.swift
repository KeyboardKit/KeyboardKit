//
//  KeyboardAction+ActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
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

    func testStandardGestureActionUsesStandardActionProperties() {

        func result(for action: KeyboardAction, gesture: KeyboardGesture, expected: KeyboardAction.GestureAction?) -> Bool {
            let result = action.standardAction(for: gesture)
            let lhs = result == nil
            let rhs = expected == nil
            return lhs == rhs
        }

        actions.forEach {
            XCTAssertTrue(result(for: $0, gesture: .doubleTap, expected: $0.standardDoubleTapAction))
            XCTAssertTrue(result(for: $0, gesture: .longPress, expected: $0.standardLongPressAction))
            XCTAssertTrue(result(for: $0, gesture: .press, expected: $0.standardPressAction))
            XCTAssertTrue(result(for: $0, gesture: .release, expected: nil)) // $0.standardReleaseAction))
            XCTAssertTrue(result(for: $0, gesture: .repeatPress, expected: $0.standardRepeatAction))
            XCTAssertTrue(result(for: $0, gesture: .tap, expected: $0.standardReleaseAction))
        }
    }

    func testStandardGestureActionPropertiesAreDefinedForSomeGestures() {
        var action: (KeyboardAction) -> KeyboardAction.GestureAction?

        action = { $0.standardDoubleTapAction }
        expected = []
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardLongPressAction }
        expected = [.backspace, .space]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardPressAction }
        expected = [
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
            .backspace,
            .character(""),
            .characterMargin(""),
            .dismissKeyboard,
            .emoji(Emoji("")),
            .moveCursorBackward,
            .moveCursorForward,
            .nextLocale,
            .primary(.done),
            .primary(.go),
            .primary(.newLine),
            .primary(.ok),
            .primary(.search),
            .primary(.return),
            .shift(currentState: .lowercased),
            .shift(currentState: .uppercased),
            .shift(currentState: .capsLocked),
            .space,
            .tab
        ]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }

        action = { $0.standardRepeatAction }
        expected = [.backspace]
        expected.forEach { XCTAssertNotNil(action($0)) }
        unexpected.forEach { XCTAssertNil(action($0)) }
    }
}
#endif
