//
//  Autocomplete+TextReplacementDictionaryTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2024-06-05.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Autocomplete_TextReplacementDictionaryTests: XCTestCase {

    let danish = Locale.danish
    let english = Locale.english
    let swedish = Locale.swedish

    func testCanAddSingleReplacement() {
        var dictionary = Autocomplete.TextReplacementDictionary()
        XCTAssertNil(dictionary.textReplacement(for: "foo", locale: swedish))
        dictionary.addTextReplacement(for: "foo", with: "bar", locale: swedish)
        XCTAssertNil(dictionary.textReplacement(for: "foo", locale: english))
        XCTAssertEqual(dictionary.textReplacements(for: swedish), ["foo": "bar"])
        XCTAssertEqual(dictionary.textReplacement(for: "foo", locale: swedish), "bar")
    }

    func testCanAddMultipleReplacements() {
        var dictionary = Autocomplete.TextReplacementDictionary()
        XCTAssertNil(dictionary.textReplacement(for: "foo", locale: danish))
        dictionary.addTextReplacements(["foo": "bar", "bar": "baz"], for: danish)
        XCTAssertNil(dictionary.textReplacement(for: "foo", locale: english))
        XCTAssertEqual(dictionary.textReplacements(for: danish), ["foo": "bar", "bar": "baz"])
        XCTAssertEqual(dictionary.textReplacement(for: "foo", locale: danish), "bar")
        XCTAssertEqual(dictionary.textReplacement(for: "bar", locale: danish), "baz")
    }
}
