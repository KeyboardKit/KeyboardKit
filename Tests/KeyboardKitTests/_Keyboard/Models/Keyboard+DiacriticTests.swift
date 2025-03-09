//
//  Keyboard+DiacriticTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-03-09.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

private extension Keyboard.Diacritic {
    
    static var test: Keyboard.Diacritic {
        .init(
            char: "!",
            replacements: [
                "r" : "r`",
                "uo": "ùò",
                "uoi": "ùòì"
            ]
        )
    }
}

class Keyboard_DiacriticTests: XCTestCase {
    
    func result(
        for text: String
    ) -> Keyboard.DiacriticInsertionResult {
        Keyboard.Diacritic.test.insertionResult(whenAppendedTo: text)
    }
    
//    func testInsertionResultInsertDiacriticCharForEmptyString() {
//        let result = result(for: "")
//        XCTAssertEqual(result.deleteBackwardsCount, 0)
//        XCTAssertEqual(result.textInsertion, "!")
//    }
//    
//    func testInsertionResultInsertDiacriticCharWhenNothingMatches() {
//        let result = result(for: "foo")
//        XCTAssertEqual(result.deleteBackwardsCount, 0)
//        XCTAssertEqual(result.textInsertion, "!")
//    }
    
    func testInsertionResultChecksLongerKeysFirst() {
        let keys = Keyboard.Diacritic.test.sortedReplacementKeys
        XCTAssertEqual(keys, ["uoi", "uo", "r"])
    }
    
    func testInsertionResultMatchesExactly() {
        let result = result(for: "bar")
        XCTAssertEqual(result.deleteBackwardsCount, 1)
        XCTAssertEqual(result.textInsertion, "r`")
    }
    
    func testInsertionResultMatchesWithCasing() {
        let result = result(for: "baR")
        XCTAssertEqual(result.deleteBackwardsCount, 1)
        XCTAssertEqual(result.textInsertion, "R`")
    }
    
    func testInsertionResultMatchesMultiCharKeyWithCasing() {
        XCTAssertEqual(result(for: "buo").deleteBackwardsCount, 2)
        XCTAssertEqual(result(for: "buo").textInsertion, "ùò")
        XCTAssertEqual(result(for: "bUo").deleteBackwardsCount, 2)
        XCTAssertEqual(result(for: "bUo").textInsertion, "Ùò")
        XCTAssertEqual(result(for: "bUO").deleteBackwardsCount, 2)
        XCTAssertEqual(result(for: "bUO").textInsertion, "ÙÒ")
    }
}
