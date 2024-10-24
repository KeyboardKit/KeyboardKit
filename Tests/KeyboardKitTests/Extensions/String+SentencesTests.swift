//
//  String+SentencesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class String_SentencesTests: XCTestCase {
    
    func testStringDefinesDelimiters() {
        let delimiters = String.sentenceDelimiters
        let expected = ".:!¡?¿".chars
        XCTAssertEqual(delimiters, expected)
        XCTAssertEqual([String].sentenceDelimiters, delimiters)
    }

    func testStringCanIdentifyAsDelimiter() {
        let result = String.sentenceDelimiters.map { $0.isSentenceDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 })
        XCTAssertFalse("a".isSentenceDelimiter)
    }

    func testIsLastSentenceEnded() {
        XCTAssertFalse("some text".isLastSentenceEnded)
        XCTAssertFalse("some text ".isLastSentenceEnded)
        XCTAssertTrue("some text.".isLastSentenceEnded)
        XCTAssertTrue("some text. ".isLastSentenceEnded)
        XCTAssertFalse("foo\n".isLastSentenceEnded)
        XCTAssertTrue("foo!\n".isLastSentenceEnded)
    }


    func testIsLastSentenceEndedWithTrailingWhitespace() {
        XCTAssertFalse("some text".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertFalse("some text.".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("some text. ".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("some text.  ".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue(" ".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("\n".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertFalse("foo".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertFalse("foo.".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertFalse("foo\n".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("foo!\n".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("foo!\n\n".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("foo. ".isLastSentenceEndedWithTrailingWhitespace)
        XCTAssertTrue("foo.   ".isLastSentenceEndedWithTrailingWhitespace)
    }


    func testLastSentence(in text: String, expected: String?) {
        XCTAssertEqual(text.lastSentence, expected)
    }

    func testLastSentence() {
        testLastSentence(in: "", expected: nil)
        testLastSentence(in: "sentence", expected: nil)
        testLastSentence(in: "sentence.", expected: "sentence")
        testLastSentence(in: "sentence!", expected: "sentence")
        testLastSentence(in: " sentence .", expected: " sentence ")
        testLastSentence(in: "sentence. ", expected: nil)
        testLastSentence(in: "sentence. a", expected: nil)
        testLastSentence(in: "sentence.a", expected: nil)
    }
}
#endif
