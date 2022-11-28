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
    
    func stringCanIdentifySentenceDelimiter() {
        let result = String.sentenceDelimiters.map { $0.isSentenceDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isSentenceDelimiter)
    }

    func stringCanIdentifyWordDelimiter() {
        let result = String.wordDelimiters.map { $0.isWordDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isWordDelimiter)
    }

    func stringProvidesSentenceDelimiters() {
        XCTAssertEqual(String.sentenceDelimiters, ["!", ".", "?"])
    }

    func stringProvidesWordDelimiters() {
        let expected = "!.?,;:()[]{}<>".chars + [" ", .newline]
        XCTAssertEqual(String.wordDelimiters, expected)
    }
}
