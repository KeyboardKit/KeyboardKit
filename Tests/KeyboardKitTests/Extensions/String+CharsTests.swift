//
//  String+Chars.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-31.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_CharsTests: XCTestCase {
    
    func charsSplitsStringIntoIndividualCharacters() {
        let string = "foo"
        let result = string.chars
        XCTAssertEqual(result, ["f", "o", "o"])
    }

    func characterCollectionHasValidValues() {
        XCTAssertEqual(String.carriageReturn, "\r")
        XCTAssertEqual(String.newline, "\n")
        XCTAssertEqual(String.space, " ")
        XCTAssertEqual(String.tab, "\t")
        XCTAssertEqual(String.zeroWidthSpace, "\u{200B}")
    }
}
