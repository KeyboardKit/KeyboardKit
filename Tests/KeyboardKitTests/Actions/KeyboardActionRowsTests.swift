//
//  KeyboardActionRowsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardActionRowsTests: XCTestCase {

    func testCanCreateActionRowsFromStringArrays() {
        let chars = [["a", "b"], ["c"]]
        let rows = KeyboardActionRows(characters: chars)
        XCTAssertEqual(rows.count, 2)
        XCTAssertEqual(rows[0].count, 2)
        XCTAssertEqual(rows[1].count, 1)
        XCTAssertEqual(rows[0][0], .character("a"))
        XCTAssertEqual(rows[0][1], .character("b"))
        XCTAssertEqual(rows[1][0], .character("c"))
    }
}
