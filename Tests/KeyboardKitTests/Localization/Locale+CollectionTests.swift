//
//  Locale+CollectionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-10.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_CollectionTests: XCTestCase {

    let english = Locale.english
    let finnish = Locale.finnish
    let hungarian = Locale.hungarian
    let swedish = Locale.swedish

    func testInsertingFirstReturnsValidArray() {
        let locales = [finnish, hungarian]
        let result = locales.insertingFirst(swedish)
        XCTAssertEqual(result, [swedish, finnish, hungarian])
    }

    func testInsertingFirstRemovesDuplicates() {
        let locales = [finnish, hungarian]
        let result = locales.insertingFirst(hungarian)
        XCTAssertEqual(result, [hungarian, finnish])
    }


    func testRemovingReturnsValidArray() {
        let locales = [finnish, hungarian]
        let result = locales.removing(hungarian)
        XCTAssertEqual(result, [finnish])
    }

    func testRemovingDoesNothingIfLocaleIsMissing() {
        let locales = [finnish, hungarian]
        let result = locales.removing(swedish)
        XCTAssertEqual(result, [finnish, hungarian])
    }


    func testSortedUsesTheStandardLocalizedNameByDefault() {
        let locales = [
            finnish,   // fi, soumi  (last)
            hungarian  // hu, magyar (first)
        ]
        let result = locales.sorted()
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["hu", "fi"])
    }

    func testSortedCanPlaceLocaleFirst() {
        let locales = [
            finnish,   // fi, soumi  (last)
            hungarian  // hu, magyar (first)
        ]
        let result = locales.sorted(insertFirst: swedish)
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["sv", "hu", "fi"])
    }

    func testSortedInLocaleUsesTheLocaleLocalizedName() {
        let locales = [
            finnish,   // fi, Finnish (first)
            hungarian  // hu, Hungarian (last)
        ]
        let result = locales.sorted(in: english)
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["fi", "hu"])
    }

    func testSortedInLocaleCanPlaceLocaleFirst() {
        let locales = [
            finnish,   // fi, Finnish (first)
            hungarian  // hu, Hungarian (last)
        ]
        let result = locales.sorted(
            in: english,
            insertFirst: .swedish
        )
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["sv", "fi", "hu"])
    }
}
