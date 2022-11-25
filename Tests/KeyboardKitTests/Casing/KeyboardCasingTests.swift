//
//  KeyboardCasingTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCasingTests: XCTestCase {

    func isLowercased(for state: KeyboardCasing) -> Bool {
        return state.isLowercased
    }

    func isUppercased(for state: KeyboardCasing) -> Bool {
        return state.isUppercased
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
