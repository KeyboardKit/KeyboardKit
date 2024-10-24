//
//  String+CharactersTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_CharactersTests: XCTestCase {

    func testStringDefinesCharacters() {
        XCTAssertEqual(String.carriageReturn, "\r")
        XCTAssertEqual(String.newline, "\n")
        XCTAssertEqual(String.space, " ")
        XCTAssertEqual(String.tab, "\t")
        XCTAssertEqual(String.zeroWidthSpace, "\u{200B}")

        XCTAssertEqual([String].sentenceDelimiters, String.sentenceDelimiters)
        XCTAssertEqual([String].wordDelimiters, String.wordDelimiters)
    }
}
