//
//  KeyboardCharactersTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCharactersTests: XCTestCase {
    
    func testCharactersHaveExpectedValues() {
        XCTAssertEqual(KeyboardCharacters.carriageReturn, "\r")
        XCTAssertEqual(KeyboardCharacters.newline, "\n")
        XCTAssertEqual(KeyboardCharacters.space, " ")
        XCTAssertEqual(KeyboardCharacters.tab, "\t")
        XCTAssertEqual(KeyboardCharacters.zeroWidthSpace, "\u{200B}")
        XCTAssertEqual(KeyboardCharacters.carriageReturn, "\r")
        XCTAssertEqual(KeyboardCharacters.newline, "\n")
    }
}
