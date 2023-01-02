//
//  Locale+BehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_BehaviorTests: XCTestCase {

    func testPrefersAlternateQuotationReplacementIsFalseForEnglish() {
        KeyboardLocale.allCases.forEach {
            let result = $0.prefersAlternateQuotationReplacement
            XCTAssertNotEqual(result, $0.localeIdentifier.hasPrefix("en"))
        }
    }
}
