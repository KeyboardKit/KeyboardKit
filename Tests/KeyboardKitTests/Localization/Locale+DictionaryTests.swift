//
//  Locale+DictionaryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_DictionaryTests: XCTestCase {
    
    var typedDict: Locale.Dictionary<String>!
    var stringDict: Locale.Dictionary<String>!
    var intDict: Locale.Dictionary<Int>!

    override func setUp() {
        typedDict = Locale.Dictionary(
            [
                .english: "English",
                .german: "German",
                .italian: "Italian",
                .swedish: "Swedish"
            ]
        )

        stringDict = Locale.Dictionary(
            [
                Locale.english.identifier: "English",
                Locale.german.identifier: "German",
                Locale.italian.identifier: "Italian",
                Locale.swedish.identifier: "Swedish"
            ]
        )

        intDict = Locale.Dictionary(
            [
                .english: 1,
                .german: 2,
                .italian: 3,
                .swedish: 4
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

    func testLocaleDictionaryCanResolveExistingValuesForLocale() {
        let locale = Locale.swedish
        XCTAssertEqual(typedDict.value(for: locale), "Swedish")
        XCTAssertEqual(stringDict.value(for: locale), "Swedish")
        XCTAssertEqual(intDict.value(for: locale), 4)
    }

    func testLocaleDictionaryCanResolveExistingValuesForLocaleLanguageCode() {
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
        let locale = Locale.danish
        XCTAssertNil(intDict.value(for: locale))
        intDict.set(10, for: locale)
        XCTAssertEqual(intDict.value(for: locale), 10)
    }
}
