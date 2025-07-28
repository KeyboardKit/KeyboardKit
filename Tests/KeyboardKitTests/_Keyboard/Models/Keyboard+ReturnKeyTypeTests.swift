//
//  Keyboard+ReturnKeyTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Keyboard_ReturnKeyTypeTests: XCTestCase {

    func assertId(for type: Keyboard.ReturnKeyType, _ expected: String) {
        XCTAssertEqual(type.id, expected)
    }

    func assertStandardButtonImage(
        for type: Keyboard.ReturnKeyType,
        _ context: KeyboardContext,
        _ expected: Bool
    ) {
        XCTAssertEqual(type.standardButtonImage(for: context) != nil, expected)
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
        XCTAssertEqual(cases, [
            .return, .continue, .done, .emergencyCall,
            .go, .join, .newLine, .next, .ok, .route,
            .search, .send]
        )
    }

    func testStandardButtonImageIsValidForLegacyDesign() {
        let context = KeyboardContext.preview
        context.isLiquidGlassEnabled = false
        assertStandardButtonImage(for: .return, context, false)
        assertStandardButtonImage(for: .done, context, false)
        assertStandardButtonImage(for: .go, context, false)
        assertStandardButtonImage(for: .join, context, false)
        assertStandardButtonImage(for: .newLine, context, true)
        assertStandardButtonImage(for: .ok, context, false)
        assertStandardButtonImage(for: .search, context, false)
        assertStandardButtonImage(for: .send, context, false)
        assertStandardButtonImage(for: .custom(title: "foobar"), context, false)
    }

    func testStandardButtonImageIsValidForLiquidGlass() {
        let context = KeyboardContext.preview
        context.isLiquidGlassEnabled = true
        assertStandardButtonImage(for: .return, context, true)
        assertStandardButtonImage(for: .done, context, true)
        assertStandardButtonImage(for: .go, context, true)
        assertStandardButtonImage(for: .join, context, true)
        assertStandardButtonImage(for: .newLine, context, true)
        assertStandardButtonImage(for: .ok, context, false)
        assertStandardButtonImage(for: .search, context, true)
        assertStandardButtonImage(for: .send, context, false)
        assertStandardButtonImage(for: .custom(title: "foobar"), context, false)
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
