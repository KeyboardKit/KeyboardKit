//
//  KeyboardLocale+QueryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-16.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_QueryTests: XCTestCase {

    func testLocaleQueryAlwaysMatchesLocalName() {
        let locale = KeyboardLocale.swedish
        XCTAssertTrue(locale.matches(query: "svE", in: .swedish))
        XCTAssertTrue(locale.matches(query: "sKa", in: .swedish))
        XCTAssertTrue(locale.matches(query: "Sve", in: .english))
        XCTAssertTrue(locale.matches(query: "skA", in: .english))
    }

    func testLocaleQueryAlwaysMatchesLocalizedName() {
        let locale = KeyboardLocale.swedish
        XCTAssertTrue(locale.matches(query: "sWe", in: .english))
        XCTAssertTrue(locale.matches(query: "disH", in: .english))
        XCTAssertFalse(locale.matches(query: "Swe", in: .danish))
        XCTAssertFalse(locale.matches(query: "diSh", in: .danish))
    }
}
