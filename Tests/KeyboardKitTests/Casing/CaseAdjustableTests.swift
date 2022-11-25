//
//  CaseAdjustableTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class CaseAdjustableTests: XCTestCase {

    func result(for string: String, text: String) -> String {
        string.caseAdjusted(for: text)
    }

    func testCaseAdjustedForTextIsCapitalizedForSingleUppercasedChar() {
        let result = result(for: "testing this", text: "T")
        XCTAssertEqual(result, "Testing This")
    }

    func testCaseAdjustedForTextIsCapitalizedForCapitalizedText() {
        let result = result(for: "testing this", text: "Test")
        XCTAssertEqual(result, "Testing This")
    }

    func testCaseAdjustedForTextIsUppercasedForUppercasedText() {
        let result = result(for: "testing this", text: "TEST")
        XCTAssertEqual(result, "TESTING THIS")
    }

    func testCaseAdjustedForTextIsLowercasedForLowercasedText() {
        let result = result(for: "TESTING THIS", text: "test")
        XCTAssertEqual(result, "testing this")
    }
}
