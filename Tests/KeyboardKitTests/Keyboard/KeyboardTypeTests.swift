//
//  KeyboardTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardTypeTests: XCTestCase {
    
    func isAlphabeticResult(for type: KeyboardType) -> Bool {
        type.isAlphabetic
    }

    func testIsAlphabeticIsOnlyTrueForAlphabeticTypes() {
        XCTAssertTrue(isAlphabeticResult(for: .alphabetic(.lowercased)))
        XCTAssertTrue(isAlphabeticResult(for: .alphabetic(.uppercased)))
        XCTAssertTrue(isAlphabeticResult(for: .alphabetic(.capsLocked)))
        XCTAssertFalse(isAlphabeticResult(for: .numeric))
        XCTAssertFalse(isAlphabeticResult(for: .symbolic))
        XCTAssertFalse(isAlphabeticResult(for: .email))
        XCTAssertFalse(isAlphabeticResult(for: .emojis))
        XCTAssertFalse(isAlphabeticResult(for: .images))
        XCTAssertFalse(isAlphabeticResult(for: .images))
        XCTAssertFalse(isAlphabeticResult(for: .custom(named: "")))
    }
}
