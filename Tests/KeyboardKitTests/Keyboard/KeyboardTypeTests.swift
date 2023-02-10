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

    func isAlphabetic(_ type: KeyboardType) -> Bool {
        type.isAlphabetic
    }

    func isAlphabeticUppercased(_ type: KeyboardType) -> Bool {
        type.isAlphabeticUppercased
    }

    func isAlphabetic(_ type: KeyboardType, _ keyboardCase: KeyboardCase) -> Bool {
        type.isAlphabetic(keyboardCase)
    }

    func testIsAlphabeticIsOnlyTrueForAlphabeticTypes() {
        XCTAssertTrue(isAlphabetic(.alphabetic(.lowercased)))
        XCTAssertTrue(isAlphabetic(.alphabetic(.uppercased)))
        XCTAssertTrue(isAlphabetic(.alphabetic(.capsLocked)))
        XCTAssertFalse(isAlphabetic(.numeric))
        XCTAssertFalse(isAlphabetic(.symbolic))
        XCTAssertFalse(isAlphabetic(.email))
        XCTAssertFalse(isAlphabetic(.emojis))
        XCTAssertFalse(isAlphabetic(.images))
        XCTAssertFalse(isAlphabetic(.images))
        XCTAssertFalse(isAlphabetic(.custom(named: "")))
    }

    func testIsAlphabeticUppercasedIsTrueForUppercaseOrCapslock() {
        XCTAssertFalse(isAlphabeticUppercased(.alphabetic(.lowercased)))
        XCTAssertTrue(isAlphabeticUppercased(.alphabetic(.uppercased)))
        XCTAssertTrue(isAlphabeticUppercased(.alphabetic(.capsLocked)))
    }

    func testIsAlphabeticWithCaseIsTrueForMatchingTypes() {
        XCTAssertFalse(isAlphabetic(.alphabetic(.lowercased), .uppercased))
        XCTAssertTrue(isAlphabetic(.alphabetic(.uppercased), .uppercased))
        XCTAssertTrue(isAlphabetic(.alphabetic(.capsLocked) ,.capsLocked))
    }
}
