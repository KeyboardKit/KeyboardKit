//
//  KeyboardStateInspectorTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import XCTest

@testable import KeyboardKit

class KeyboardStateInspectorTests: XCTestCase {

    private var inspector: TestInspector!

    let bundleIds = ["com.myapp.keyboard.1", "com.myapp.keyboard.2"]

    override func setUp() {
        inspector = TestInspector()
    }

    func activeResult(for id: String) -> Bool {
        inspector.isKeyboardActive(withId: id, in: bundleIds)
    }

    func enabledResult(for id: String) -> Bool {
        inspector.isKeyboardEnabled(withId: id, in: bundleIds)
    }

    func testIsKeyboardActiveMatchesOnExactBundleId() {
        XCTAssertTrue(activeResult(for: "com.myapp.keyboard.1"))
        XCTAssertFalse(activeResult(for: "com.myapp.keyboard.2"))
    }

    func testIsKeyboardActiveMatchesOnWildcard() {
        XCTAssertTrue(activeResult(for: "com.myapp.keyboard.*"))
        XCTAssertFalse(activeResult(for: "com.myapp.anotherkeyboard.*"))
    }

    func testIsKeyboardEnabledMatchesOnExactBundleId() {
        XCTAssertTrue(enabledResult(for: "com.myapp.keyboard.1"))
        XCTAssertTrue(enabledResult(for: "com.myapp.keyboard.2"))
    }

    func testIsKeyboardEnabledMatchesOnWildcard() {
        XCTAssertTrue(enabledResult(for: "com.myapp.keyboard.*"))
        XCTAssertFalse(enabledResult(for: "com.myapp.anotherkeyboard.*"))
    }
}

private class TestInspector: KeyboardStateInspector {}
#endif
