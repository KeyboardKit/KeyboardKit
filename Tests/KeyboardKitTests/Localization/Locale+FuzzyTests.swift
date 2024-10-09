//
//  Locale+FuzzyTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-10.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_FuzzyTests: XCTestCase {

    func testCanResolveLocaleWithFuzzyName() {
        func result(for name: String) -> String? {
            Locale(fuzzyName: name)?.identifier
        }
        XCTAssertEqual(result(for: "Swedish"), "sv")
        XCTAssertEqual(result(for: "swedish"), "sv")
        XCTAssertEqual(result(for: "english gb"), "en_GB")
    }
}
