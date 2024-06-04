//
//  KeyboardLocale+AllTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_AllTests: XCTestCase {

    func testAllContainsAllLocales() {
        XCTAssertEqual(KeyboardLocale.all, KeyboardLocale.allCases)
    }

    func testAllLtrOnlyContainsLtrLocales() {
        KeyboardLocale.allLtr.forEach {
            XCTAssertTrue($0.locale.isLeftToRight)
            XCTAssertFalse($0.locale.isRightToLeft)
        }
    }
    
    func testAllRtlOnlyContainsRtlLocales() {
        KeyboardLocale.allRtl.forEach {
            XCTAssertFalse($0.locale.isLeftToRight)
            XCTAssertTrue($0.locale.isRightToLeft)
        }
    }
}
