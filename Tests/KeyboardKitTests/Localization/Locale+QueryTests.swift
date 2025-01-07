//
//  Locale+QueryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-16.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_QueryTests: XCTestCase {

    let locale = Locale.swedish

    func testLocaleQueryAlwaysMatchesLocalName() {
        XCTAssertTrue(locale.matches(query: "svE", in: .swedish))
        XCTAssertTrue(locale.matches(query: "sKa", in: .swedish))
        XCTAssertTrue(locale.matches(query: "Sve", in: .english))
        XCTAssertTrue(locale.matches(query: "skA", in: .english))
    }

    func testLocaleQueryAlwaysMatchesLocalizedName() {
        XCTAssertTrue(locale.matches(query: "sWe", in: .english))
        XCTAssertTrue(locale.matches(query: "disH", in: .english))
        XCTAssertFalse(locale.matches(query: "Swe", in: .danish))
        XCTAssertFalse(locale.matches(query: "diSh", in: .danish))
    }
}
