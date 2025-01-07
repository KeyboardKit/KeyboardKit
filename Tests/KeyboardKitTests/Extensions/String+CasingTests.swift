//
//  String+CasingTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-05.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class String_CasingTests: XCTestCase {
    
    func stringIsLowercasedWithUppercaseVariantIfUppercaseDiffers() {
        XCTAssertFalse("Foobar".isLowercasedWithUppercaseVariant)
        XCTAssertTrue("a".isLowercasedWithUppercaseVariant)
        XCTAssertFalse("A".isLowercasedWithUppercaseVariant)
        XCTAssertFalse("1".isLowercasedWithUppercaseVariant)
        XCTAssertFalse("$".isLowercasedWithUppercaseVariant)
    }
    
    func stringIsUppercasedWithLowercaseVariantIfUppercaseDiffers() {
        XCTAssertFalse("Foobar".isUppercasedWithLowercaseVariant)
        XCTAssertFalse("a".isUppercasedWithLowercaseVariant)
        XCTAssertTrue("A".isUppercasedWithLowercaseVariant)
        XCTAssertFalse("1".isUppercasedWithLowercaseVariant)
        XCTAssertFalse("$".isUppercasedWithLowercaseVariant)
    }
}
