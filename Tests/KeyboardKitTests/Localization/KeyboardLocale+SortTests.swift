//
//  KeyboardLocale+SortTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocale_SortTests: XCTestCase {

    func locale(_ locale: KeyboardLocale) -> KeyboardLocale { locale }
    
    func testSortedUsesTheStandardLocalizedNameByDefault() {
        let locales = [
            locale(.finnish),   // fi, soumi  (last)
            locale(.hungarian)  // hu, magyar (first)
        ]
        let result = locales.sorted()
        let ids = result.map { $0.id }
        XCTAssertEqual(ids, ["hu", "fi"])
    }

    func testSortedInLocaleUsesTheLocaleLocalizedName() {
        let locales = [
            locale(.finnish),   // fi, Finnish (first)
            locale(.hungarian)  // hu, Hungarian (last)
        ]
        let result = locales.sorted(in: locale(.english).locale)
        let ids = result.map { $0.id }
        XCTAssertEqual(ids, ["fi", "hu"])
    }
}
