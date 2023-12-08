//
//  LocaleDictionaryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class LocaleDictionaryTests: XCTestCase {
    
    var typedDict: LocaleDictionary<String>!
    var stringDict: LocaleDictionary<String>!
    var intDict: LocaleDictionary<Int>!

    override func setUp() {
        typedDict = LocaleDictionary(
            [
                .english: "English",
                .german: "German",
                .italian: "Italian",
                .swedish: "Swedish"
            ]
        )

        stringDict = LocaleDictionary(
            [
                KeyboardLocale.english.id: "English",
                KeyboardLocale.german.id: "German",
                KeyboardLocale.italian.id: "Italian",
                KeyboardLocale.swedish.id: "Swedish"
            ]
        )

        intDict = LocaleDictionary(
            [
                KeyboardLocale.english.id: 1,
                KeyboardLocale.german.id: 2,
                KeyboardLocale.italian.id: 3,
                KeyboardLocale.swedish.id: 4
            ]
        )
    }

    func testLocaleDictionaryCanBeCreatedWithAnyItemType() {
        XCTAssertEqual(typedDict.dictionary.keys.sorted(), ["de", "en", "it", "sv"])
        XCTAssertNotNil(typedDict)
        XCTAssertEqual(stringDict.dictionary.keys.sorted(), ["de", "en", "it", "sv"])
        XCTAssertNotNil(stringDict)
        XCTAssertNotNil(intDict)
    }

    func testLocaleDictionaryCanResolveExistingValuesOnLocale() {
        let locale = KeyboardLocale.swedish.locale
        XCTAssertEqual(typedDict.value(for: locale), "Swedish")
        XCTAssertEqual(stringDict.value(for: locale), "Swedish")
        XCTAssertEqual(intDict.value(for: locale), 4)
    }

    func testLocaleDictionaryCanResolveExistingValuesOnLocaleLanguageCode() {
        let locale = Locale(identifier: "sv-SE")
        XCTAssertEqual(typedDict.value(for: locale), "Swedish")
        XCTAssertEqual(stringDict.value(for: locale), "Swedish")
        XCTAssertEqual(intDict.value(for: locale), 4)
    }

    func testLocaleDictionaryReturnsNilForNonExistingLocale() {
        let locale = Locale(identifier: "abc")
        XCTAssertNil(typedDict.value(for: locale))
        XCTAssertNil(stringDict.value(for: locale))
        XCTAssertNil(intDict.value(for: locale))
    }
    
    func testCanRegisterAdditionalValues() {
        let locale = KeyboardLocale.danish
        XCTAssertNil(intDict.value(for: locale))
        intDict.set(10, for: locale)
        XCTAssertEqual(intDict.value(for: locale), 10)
    }
}
