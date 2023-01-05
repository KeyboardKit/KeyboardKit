//
//  KeyboardAction+PrimaryTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_PrimaryTypeTests: XCTestCase {

    func assertId(for type: KeyboardAction.PrimaryType, _ expected: String) {
        XCTAssertEqual(type.id, expected)
    }

    func assertStandardButtonImage(for type: KeyboardAction.PrimaryType, _ expected: Bool) {
        XCTAssertEqual(type.standardButtonImage(for: .current) != nil, expected)
    }

    func assertStandardButtonText(for type: KeyboardAction.PrimaryType, _ expected: Bool) {
        XCTAssertEqual(type.standardButtonText(for: .current) != nil, expected)
    }

    func testIdIsValid() {
        assertId(for: .return,  "return")
        assertId(for: .done,  "done")
        assertId(for: .go,  "go")
        assertId(for: .join,  "join")
        assertId(for: .newLine,  "newLine")
        assertId(for: .ok,  "ok")
        assertId(for: .search,  "search")
        assertId(for: .custom(title: "foobar"),  "foobar")
    }

    func testAllCasesReturnsAllTypesExceptCustom() {
        let cases = KeyboardAction.PrimaryType.allCases
        XCTAssertEqual(cases, [.return, .done, .go, .join, .newLine, .ok, .search])
    }

    func testStandardButtonImageIsValid() {
        assertStandardButtonImage(for: .return, false)
        assertStandardButtonImage(for: .done, false)
        assertStandardButtonImage(for: .go, false)
        assertStandardButtonImage(for: .join, false)
        assertStandardButtonImage(for: .newLine, true)
        assertStandardButtonImage(for: .ok, false)
        assertStandardButtonImage(for: .search, false)
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
        assertStandardButtonText(for: .custom(title: "foobar"), true)
    }
}
