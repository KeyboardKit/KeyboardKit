//
//  Keyboard+ReturnKeyTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Keyboard_ReturnKeyTypeTests: XCTestCase {

    func assertId(for type: Keyboard.ReturnKeyType, _ expected: String) {
        XCTAssertEqual(type.id, expected)
    }

    func assertStandardButtonImage(for type: Keyboard.ReturnKeyType, _ expected: Bool) {
        XCTAssertEqual(type.standardButtonImage(for: .current) != nil, expected)
    }

    func assertStandardButtonText(for type: Keyboard.ReturnKeyType, _ expected: Bool) {
        XCTAssertEqual(type.standardButtonText(for: .current) != nil, expected)
    }

    func testIdIsValid() {
        assertId(for: .return, "return")
        assertId(for: .done, "done")
        assertId(for: .go, "go")
        assertId(for: .join, "join")
        assertId(for: .newLine, "newLine")
        assertId(for: .ok, "ok")
        assertId(for: .search, "search")
        assertId(for: .send, "send")
        assertId(for: .custom(title: "foobar"), "foobar")
    }

    func testAllCasesReturnsAllTypesExceptCustom() {
        let cases = Keyboard.ReturnKeyType.allCases
        XCTAssertEqual(cases, [.return, .done, .go, .join, .newLine, .next, .ok, .search, .send])
    }

    func testStandardButtonImageIsValid() {
        assertStandardButtonImage(for: .return, false)
        assertStandardButtonImage(for: .done, false)
        assertStandardButtonImage(for: .go, false)
        assertStandardButtonImage(for: .join, false)
        assertStandardButtonImage(for: .newLine, true)
        assertStandardButtonImage(for: .ok, false)
        assertStandardButtonImage(for: .search, false)
        assertStandardButtonImage(for: .send, false)
        assertStandardButtonImage(for: .custom(title: "foobar"), false)
    }

    func testStandardButtonTextIsValid() {
        assertStandardButtonText(for: .return, true)
        assertStandardButtonText(for: .done, true)
        assertStandardButtonText(for: .go, true)
        assertStandardButtonText(for: .join, true)
        assertStandardButtonText(for: .newLine, false)
        assertStandardButtonText(for: .ok, true)
        assertStandardButtonText(for: .search, true)
        assertStandardButtonText(for: .send, true)
        assertStandardButtonText(for: .custom(title: "foobar"), true)
    }

    #if os(iOS) || os(tvOS)
    func assertNativeMapping(
        for type: UIReturnKeyType,
        _ expected: Keyboard.ReturnKeyType
    ) {
        XCTAssertEqual(type.keyboardType, expected)
    }

    func testCanMapNativeReturnKeyType() {
        assertNativeMapping(for: .default, .return)
        assertNativeMapping(for: .done, .done)
        assertNativeMapping(for: .go, .go)
        assertNativeMapping(for: .join, .join)
        assertNativeMapping(for: .next, .next)
        assertNativeMapping(for: .search, .search)
        assertNativeMapping(for: .send, .send)
    }
    #endif
}
