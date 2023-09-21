//
//  InputSet+ItemTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class InputSet_ItemTests: XCTestCase {
    
    func testCharacterForCasingReturnsCorrectChar() {
        let input = InputSet.Item(neutral: "n", uppercased: "u", lowercased: "l")
        XCTAssertEqual(input.character(for: .auto), "l")
        XCTAssertEqual(input.character(for: .lowercased), "l")
        XCTAssertEqual(input.character(for: .uppercased), "u")
        XCTAssertEqual(input.character(for: .capsLocked), "u")
    }
}
