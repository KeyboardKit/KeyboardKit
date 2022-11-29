//
//  KeyboardInputTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardInputTests: XCTestCase {
    
    func testCharacterForCasingReturnsCorrectChar() {
        let input = InputSetItem(neutral: "n", uppercased: "u", lowercased: "l")
        XCTAssertEqual(input.character(for: .auto), "l")
        XCTAssertEqual(input.character(for: .lowercased), "l")
        XCTAssertEqual(input.character(for: .uppercased), "u")
        XCTAssertEqual(input.character(for: .capsLocked), "u")
    }
}
