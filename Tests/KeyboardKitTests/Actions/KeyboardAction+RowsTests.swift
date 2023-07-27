//
//  KeyboardAction+RowsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_RowsTests: XCTestCase {
    
    func testCanCreateKeyboardActionRowFromStringArray() {
        let chars = ["a", "b", "c"]
        let row = KeyboardAction.Row(characters: chars)
        XCTAssertEqual(row.count, 3)
        XCTAssertEqual(row[0], .character("a"))
        XCTAssertEqual(row[1], .character("b"))
        XCTAssertEqual(row[2], .character("c"))
    }

    func testCanCreateKeyboardActionRowsFromStringArrays() {
        let chars = [["a", "b"], ["c"]]
        let rows = KeyboardAction.Rows(characters: chars)
        XCTAssertEqual(rows.count, 2)
        XCTAssertEqual(rows[0].count, 2)
        XCTAssertEqual(rows[1].count, 1)
        XCTAssertEqual(rows[0][0], .character("a"))
        XCTAssertEqual(rows[0][1], .character("b"))
        XCTAssertEqual(rows[1][0], .character("c"))
    }
}
