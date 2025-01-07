//
//  String+SentencesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import XCTest

class String_SentencesTests: XCTestCase {
    
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
        testLastSentence(in: "sentence", expected: "sentence")
        testLastSentence(in: "sentence.", expected: "sentence.")
        testLastSentence(in: "sentence!", expected: "sentence!")
        testLastSentence(in: " sentence .", expected: "sentence.")
        testLastSentence(in: "sentence. ", expected: nil)
        testLastSentence(in: "sentence. a", expected: "a")
        testLastSentence(in: "sentence.a", expected: "a")
    }
}
#endif
