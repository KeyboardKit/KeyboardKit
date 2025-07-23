//
//  InputSet+RowItemTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class InputSet_ItemTests: XCTestCase {

    typealias Item = KeyboardLayout.InputSet.Item

    func testCharacterForCasingReturnsCorrectChar() {
        let input = Item(neutral: "n", uppercased: "u", lowercased: "l")
        XCTAssertEqual(input.character(for: .auto), "l")
        XCTAssertEqual(input.character(for: .lowercased), "l")
        XCTAssertEqual(input.character(for: .uppercased), "u")
        XCTAssertEqual(input.character(for: .capsLocked), "u")
    }
}
