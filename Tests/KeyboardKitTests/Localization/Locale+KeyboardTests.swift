//
//  Locale+KeyboardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-10.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class LocaleInfo_KeyboardTests: XCTestCase {

    let english = Locale.english
    let swedish = Locale.swedish

    func testPrefersAlternateQuotationReplacement() {
        func result(for locale: Locale) -> Bool {
            locale.prefersAlternateQuotationReplacement
        }
        XCTAssertFalse(result(for: english))
        XCTAssertTrue(result(for: swedish))
    }
}
