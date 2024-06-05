//
//  Autocomplete+TextReplacementDictionaryTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2024-06-05.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Autocomplete_TextReplacementDictionaryTests: XCTestCase {

    let danish = KeyboardLocale.danish
    let english = KeyboardLocale.english
    let swedish = KeyboardLocale.swedish

    func testCanAddSingleReplacement() {
        var dictionary = Autocomplete.TextReplacementDictionary()
        XCTAssertNil(dictionary.wordReplacement(for: "foo", locale: swedish))
        dictionary.addWordReplacement("bar", for: "foo", locale: swedish)
        XCTAssertNil(dictionary.wordReplacement(for: "foo", locale: english))
        XCTAssertEqual(dictionary.wordReplacements(for: swedish), ["foo": "bar"])
        XCTAssertEqual(dictionary.wordReplacement(for: "foo", locale: swedish), "bar")
    }

    func testCanAddMultipleReplacements() {
        var dictionary = Autocomplete.TextReplacementDictionary()
        XCTAssertNil(dictionary.wordReplacement(for: "foo", locale: danish))
        dictionary.addWordReplacements(["foo": "bar", "bar": "baz"], for: danish)
        XCTAssertNil(dictionary.wordReplacement(for: "foo", locale: english))
        XCTAssertEqual(dictionary.wordReplacements(for: danish), ["foo": "bar", "bar": "baz"])
        XCTAssertEqual(dictionary.wordReplacement(for: "foo", locale: danish), "bar")
        XCTAssertEqual(dictionary.wordReplacement(for: "bar", locale: danish), "baz")
    }
}
