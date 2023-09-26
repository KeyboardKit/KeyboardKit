//
//  String+WordsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class String_WordsTests: XCTestCase {

    func testWordFragmentAtStart(in text: String, expected: String) {
        XCTAssertEqual(text.wordFragmentAtStart, expected)
    }

    func testWordFragmentAtStart() {
        testWordFragmentAtStart(in: "foo bar baz", expected: "foo")
        testWordFragmentAtStart(in: "foo.", expected: "foo")
        testWordFragmentAtStart(in: ".foo.", expected: "")
    }


    func testWordFragmentAtEnd(in text: String, expected: String) {
        XCTAssertEqual(text.wordFragmentAtEnd, expected)
    }

    func testWordFragmentAtEnd() {
        testWordFragmentAtEnd(in: "foo bar baz", expected: "baz")
        testWordFragmentAtEnd(in: ".foo", expected: "foo")
        testWordFragmentAtEnd(in: ".foo.", expected: "")
    }


    func testWord(at index: Int, in text: String, expected: String?) {
        XCTAssertEqual(text.word(at: index), expected)
    }

    func testWordAt() {
        testWord(at: 1, in: "foo bar baz", expected: "foo")
        testWord(at: 3, in: "foo bar baz", expected: "foo")
        testWord(at: 4, in: "foo bar baz", expected: "bar")
        testWord(at: 4, in: "foo  bar baz", expected: nil)
    }


    func testWordFragment(before index: Int, in text: String, expected: String?) {
        XCTAssertEqual(text.wordFragment(before: index), expected)
    }

    func testWordFragmentBeforeIndex() {
        testWordFragment(before: 1, in: "foo bar baz", expected: "f")
        testWordFragment(before: 3, in: "foo bar baz", expected: "foo")
        testWordFragment(before: 4, in: "foo bar baz", expected: "")
    }


    func testWordFragment(after index: Int, in text: String, expected: String?) {
        XCTAssertEqual(text.wordFragment(after: index), expected)
    }

    func testWordFragmentAfterIndex() {
        testWordFragment(after: 1, in: "foo bar baz", expected: "oo")
        testWordFragment(after: 3, in: "foo bar baz", expected: "")
        testWordFragment(after: 4, in: "foo bar baz", expected: "bar")
    }
}
#endif
