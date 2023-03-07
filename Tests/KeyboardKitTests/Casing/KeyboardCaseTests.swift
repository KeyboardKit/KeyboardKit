//
//  KeyboardCaseTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCaseTests: XCTestCase {

    func isLowercased(for case: KeyboardCase) -> Bool {
        return `case`.isLowercased
    }

    func isUppercased(for case: KeyboardCase) -> Bool {
        return `case`.isUppercased
    }

    func testIsLowercasedOnlyAppliesToCertainStates() {
        XCTAssertFalse(isLowercased(for: .auto))
        XCTAssertFalse(isLowercased(for: .capsLocked))
        XCTAssertTrue(isLowercased(for: .lowercased))
        XCTAssertFalse(isLowercased(for: .uppercased))
    }

    func testIsUppercasedOnlyAppliesToCertainStates() {
        XCTAssertFalse(isUppercased(for: .auto))
        XCTAssertTrue(isUppercased(for: .capsLocked))
        XCTAssertFalse(isUppercased(for: .lowercased))
        XCTAssertTrue(isUppercased(for: .uppercased))
    }
}
