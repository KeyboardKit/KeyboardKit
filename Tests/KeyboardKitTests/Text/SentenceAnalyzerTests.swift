//
//  SentenceAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class SentenceAnalyzerTests: XCTestCase {

    class Analyzer: SentenceAnalyzer {}

    var analyzer: Analyzer!
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        analyzer = Analyzer()
        proxy = MockTextDocumentProxy()
    }


    func isLastSentenceEnded(in text: String) -> Bool {
        proxy.documentContextBeforeInput = text
        let analyzerCheck = analyzer.isLastSentenceEnded(in: text)
        let instanceCheck = text.isLastSentenceEnded
        let proxyCheck = proxy.isCursorAtNewSentence
        return analyzerCheck && instanceCheck && proxyCheck
    }

    func testIsLastSentenceEnded() {
        XCTAssertFalse(isLastSentenceEnded(in: "some text"))
        XCTAssertFalse(isLastSentenceEnded(in: "some text "))
        XCTAssertTrue(isLastSentenceEnded(in: "some text."))
        XCTAssertTrue(isLastSentenceEnded(in: "some text. "))
        XCTAssertFalse(isLastSentenceEnded(in: "foo\n"))
        XCTAssertTrue(isLastSentenceEnded(in: "foo!\n"))
    }


    func isLastSentenceEndedWithTrailingWhitespace(in text: String) -> Bool {
        proxy.documentContextBeforeInput = text
        let analyzerCheck = analyzer.isLastSentenceEndedWithTrailingWhitespace(in: text)
        let instanceCheck = text.isLastSentenceEndedWithTrailingWhitespace
        let proxyCheck = proxy.isCursorAtNewSentenceWithTrailingWhitespace
        return analyzerCheck && instanceCheck && proxyCheck
    }

    func testIsLastSentenceEndedWithTrailingWhitespace() {
        XCTAssertFalse(isLastSentenceEndedWithTrailingWhitespace(in: "some text"))
        XCTAssertFalse(isLastSentenceEndedWithTrailingWhitespace(in: "some text."))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "some text. "))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "some text.  "))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: ""))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: " "))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "\n"))
        XCTAssertFalse(isLastSentenceEndedWithTrailingWhitespace(in: "foo"))
        XCTAssertFalse(isLastSentenceEndedWithTrailingWhitespace(in: "foo."))
        XCTAssertFalse(isLastSentenceEndedWithTrailingWhitespace(in: "foo\n"))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "foo!\n"))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "foo!\n\n"))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "foo. "))
        XCTAssertTrue(isLastSentenceEndedWithTrailingWhitespace(in: "foo.   "))
    }


    func testLastSentence(in text: String, expected: String?) {
        proxy.documentContextBeforeInput = text
        XCTAssertEqual(analyzer.lastSentence(in: text), expected)
        XCTAssertEqual(text.lastSentence, expected)
        XCTAssertEqual(proxy.sentenceBeforeInput, expected)
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
