//
//  Locale+LocalizedTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_LocalizedTests: XCTestCase {
    
    func testLocalizedNameIsValid() {
        let locale = Locale(identifier: "en-US")
        XCTAssertEqual(locale.localizedName, "English (United States)")
    }

    func testLocalizedLanguageNameIsValid() {
        let locale = Locale(identifier: "en-US")
        XCTAssertEqual(locale.localizedLanguageName, "English")
    }

    func testPrefersAlternateQuotationReplacementIsValid() {
        let engligh = Locale(identifier: "en")
        let englighGb = Locale(identifier: "en-GB")
        let englighUs = Locale(identifier: "en-US")
        let other = Locale(identifier: "sv-SE")
        XCTAssertFalse(engligh.prefersAlternateQuotationReplacement)
        XCTAssertFalse(englighGb.prefersAlternateQuotationReplacement)
        XCTAssertFalse(englighUs.prefersAlternateQuotationReplacement)
        XCTAssertTrue(other.prefersAlternateQuotationReplacement)
    }
}
