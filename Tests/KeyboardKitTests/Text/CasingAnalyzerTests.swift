//
//  CasingAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class CasingAnalyzerTests: XCTestCase {

    class Analyzer: CasingAnalyzer {}

    let analyzer = Analyzer()

    func testIsCapitalizedIsOnlyTrueForCapitalizedStrings() {
        XCTAssertTrue("Foobar".isCapitalized)
        XCTAssertTrue("Foo Bar".isCapitalized)
        XCTAssertFalse("Foo bar".isCapitalized)
        XCTAssertTrue(analyzer.isCapitalized("Foobar"))
        XCTAssertTrue(analyzer.isCapitalized("Foo Bar"))
        XCTAssertFalse(analyzer.isCapitalized("Foo bar"))
    }

    func testIsLowercasedIsOnlyTrueForStringsThatCanBeAndAreLowercased() {
        XCTAssertTrue("foobar".isLowercased)
        XCTAssertFalse("fooBar".isLowercased)
        XCTAssertFalse("123".isLowercased)
        XCTAssertTrue(analyzer.isLowercased("foobar"))
        XCTAssertFalse(analyzer.isLowercased("fooBar"))
        XCTAssertFalse(analyzer.isLowercased("123"))
    }

    func testIsUppercasedIsOnlyTrueForStringsThatCanBeAndAreUppercased() {
        XCTAssertTrue("FOOBAR".isUppercased)
        XCTAssertFalse("fooBar".isUppercased)
        XCTAssertFalse("123".isUppercased)
        XCTAssertTrue(analyzer.isUppercased("FOOBAR"))
        XCTAssertFalse(analyzer.isUppercased("fooBar"))
        XCTAssertFalse(analyzer.isUppercased("123"))
    }
}
