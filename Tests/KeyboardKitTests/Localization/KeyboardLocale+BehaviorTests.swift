//
//  KeyboardLocale+BehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_BehaviorTests: XCTestCase {

    func testPrefersAlternateQuotationReplacementIsDerivedFromResolvedLocale() {
        KeyboardLocale.all.forEach {
            XCTAssertEqual($0.prefersAlternateQuotationReplacement, $0.locale.prefersAlternateQuotationReplacement)
        }
    }
    
    func testPrefersAlternateQuotationReplacementIsFalseForEnglish() {
        KeyboardLocale.allCases.forEach {
            let result = $0.prefersAlternateQuotationReplacement
            XCTAssertNotEqual(result, $0.localeIdentifier.hasPrefix("en"))
        }
    }
}
