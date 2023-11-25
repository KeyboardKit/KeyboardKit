//
//  KeyboardLocale+DirectionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_DirectionTests: XCTestCase {

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
