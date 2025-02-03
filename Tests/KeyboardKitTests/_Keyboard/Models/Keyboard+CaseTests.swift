//
//  Keyboard+CaseTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Keyboard_CaseTests: XCTestCase {

    func testIsUpperCasedOrCapsLockedIsValid() {
        func result(for case: Keyboard.KeyboardCase) -> Bool {
            return `case`.isUppercasedOrCapslocked
        }
        XCTAssertFalse(result(for: .auto))
        XCTAssertTrue(result(for: .capsLocked))
        XCTAssertFalse(result(for: .lowercased))
        XCTAssertTrue(result(for: .uppercased))
    }
}
