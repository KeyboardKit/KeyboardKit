//
//  KeyboardLocale+BehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_BehaviorTests: XCTestCase {

    func testPrefersAlternateQuotationReplacementIsDerivedFromResolvedLocale() {
        KeyboardLocale.all.forEach {
            XCTAssertEqual($0.prefersAlternateQuotationReplacement, $0.locale.prefersAlternateQuotationReplacement)
        }
    }
}
