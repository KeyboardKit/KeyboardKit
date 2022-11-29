//
//  String+DelimitersTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_DelimitersTests: XCTestCase {
    
    func testStringCanIdentifySentenceDelimiter() {
        let result = String.sentenceDelimiters.map { $0.isSentenceDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isSentenceDelimiter)
    }

    func testStringCanIdentifyWordDelimiter() {
        let result = String.wordDelimiters.map { $0.isWordDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isWordDelimiter)
    }

    func testStringProvidesSentenceDelimiters() {
        XCTAssertEqual(String.sentenceDelimiters, ["!", ".", "?"])
    }

    func testStringProvidesWordDelimiters() {
        let expected = "!.?,;:()[]{}<>".chars + [" ", .newline]
        XCTAssertEqual(String.wordDelimiters, expected)
    }
}
