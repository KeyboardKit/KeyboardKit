//
//  TextDelimitersTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class TextDelimitersTests: XCTestCase {
    
    func testSentenceDelimitersAreByDefaultWesternDelimiters() {
        let expected = ["!", ".", "?"]
        XCTAssertEqual(TextDelimiters.sentenceDelimiters, expected)
    }

    func testWordDelimitersAreByDefaultWesternDelimiters() {
        let expected = "!.?,;:()[]{}<>".chars + [" ", .newline]
        XCTAssertEqual(TextDelimiters.wordDelimiters, expected)
    }
}
