//
//  UITextDocumentProxy+ContentTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class UITextDocumentProxy_ContentTests: XCTestCase {
    
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }

    func prepareProxy(with preCursorPart: String, _ postCursorPart: String? = nil) {
        proxy.documentContextBeforeInput = preCursorPart
        proxy.documentContextAfterInput = postCursorPart
    }


    func isCursorAtNewSentence(for preCursorPart: String) -> Bool {
        prepareProxy(with: preCursorPart)
        return proxy.isCursorAtNewSentence
    }

    func testIsCursorAtNewSentenceReturnsTrueIfPreCursorPartIsMissing() {
        XCTAssertTrue(proxy.isCursorAtNewSentence)
    }

    func testIsCursorAtNewSentenceReturnsFalseIfPreCursorPartEndsWithNonSentenceDelimiter() {
        XCTAssertFalse(isCursorAtNewSentence(for: "foo"))
        XCTAssertFalse(isCursorAtNewSentence(for: "foo "))
    }

    func testIsCursorAtNewSentenceReturnsTrueIfPreCursorIsEmptyOrEndsWithSentenceDelimiter() {
        XCTAssertTrue(isCursorAtNewSentence(for: ""))
        XCTAssertTrue(isCursorAtNewSentence(for: "foo."))
        XCTAssertTrue(isCursorAtNewSentence(for: "foo! "))
    }

    func testIsCursorAtNewSentenceReturnsFalseIfPreCursorHasUnclosedSentenceAndNewline() {
        XCTAssertFalse(isCursorAtNewSentence(for: "foo\n"))
    }

    func testIsCursorAtNewSentenceReturnsFalseIfPreCursorHasClosedSentenceAndNewline() {
        XCTAssertTrue(isCursorAtNewSentence(for: "foo!\n"))
    }


    func isCursorAtNewSentenceWithSpaceResult(for preCursorPart: String) -> Bool {
        prepareProxy(with: preCursorPart)
        return proxy.isCursorAtNewSentenceWithSpace
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorPartIsMissing() {
        XCTAssertTrue(proxy.isCursorAtNewSentence)
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorIsEmpty() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: ""))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorIsSpace() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: " "))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorIsSentenceDelimiter() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: "\n"))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsFalseIfPreCursorPartEndsWithNonSentenceDelimiter() {
        XCTAssertFalse(isCursorAtNewSentenceWithSpaceResult(for: "foo"))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsFalseIfPreCursorEndsWithSentenceDelimiter() {
        XCTAssertFalse(isCursorAtNewSentenceWithSpaceResult(for: "foo."))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsFalseIfPreCursorHasUnclosedSentenceAndNewline() {
        XCTAssertFalse(isCursorAtNewSentenceWithSpaceResult(for: "foo\n"))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorHasClosedSentenceAndNewline() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: "foo!\n"))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsTrueIfPreCursorHasClosedSentenceAndMultipleNewlines() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: "foo!\n\n"))
    }

    func testIsCursorAtNewSentenceWithSpaceReturnsFalseIfPreCursorEndsWithSentenceDelimiterFollowedBySpaces() {
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: "foo. "))
        XCTAssertTrue(isCursorAtNewSentenceWithSpaceResult(for: "foo.   "))
    }


    func isCursorAtNewWordResult(for preCursorPart: String) -> Bool {
        prepareProxy(with: preCursorPart)
        return proxy.isCursorAtNewWord
    }

    func testIsCursorAtNewWordResultReturnsTrueIfPreCursorPartIsMissing() {
        XCTAssertTrue(proxy.isCursorAtNewWord)
    }

    func testIsCursorAtNewWordResultReturnsFalseIfPreCursorPartEndsWithNonWordDelimiter() {
        XCTAssertFalse(isCursorAtNewWordResult(for: "foo"))
        XCTAssertFalse(isCursorAtNewWordResult(for: "foo€"))
    }

    func testIsCursorAtNewWordResultReturnsTrueOfPreCursorIsEmptyOrEndsWithWordDelimiter() {
        XCTAssertTrue(isCursorAtNewWordResult(for: ""))
        XCTAssertTrue(isCursorAtNewWordResult(for: "foo."))
        XCTAssertTrue(isCursorAtNewWordResult(for: "foo! "))
    }


    func sentenceBeforeInputResult(for preCursorPart: String, _ postCursorPart: String) -> String? {
        prepareProxy(with: preCursorPart, postCursorPart)
        return proxy.sentenceBeforeInput
    }

    func testSentenceBeforeInputResultReturnsLastEndedSentenceIfAny() {
        XCTAssertNil(sentenceBeforeInputResult(for: "", ""))
        XCTAssertNil(sentenceBeforeInputResult(for: "sentence", ""))
        XCTAssertEqual(sentenceBeforeInputResult(for: "sentence.", ""), "sentence")
        XCTAssertEqual(sentenceBeforeInputResult(for: "sentence!", ""), "sentence")
        XCTAssertEqual(sentenceBeforeInputResult(for: "sentence .", ""), "sentence ")
        XCTAssertNil(sentenceBeforeInputResult(for: "sentence. ", ""))
        XCTAssertNil(sentenceBeforeInputResult(for: "sentence. a", ""))
        XCTAssertNil(sentenceBeforeInputResult(for: "sentence.a", ""))
    }


    func wordBeforeInputResult(for preCursorPart: String, _ postCursorPart: String) -> String? {
        prepareProxy(with: preCursorPart, postCursorPart)
        return proxy.wordBeforeInput
    }

    func testWordBeforeInputReturnsPreviousWordIfOneExistsAndCursorIsNotAtTheBeginningOfNewSentence() {
        XCTAssertNil(wordBeforeInputResult(for: "word", ""))
        XCTAssertEqual(wordBeforeInputResult(for: "word ", ""), "word")
        XCTAssertNil(wordBeforeInputResult(for: "word. ", ""))
        XCTAssertEqual(wordBeforeInputResult(for: "one two . three ", ""), "three")
        XCTAssertNil(wordBeforeInputResult(for: "word...", ""))
        XCTAssertNil(wordBeforeInputResult(for: "word,,,", ""))
        XCTAssertEqual(wordBeforeInputResult(for: "word,", ""), "word")
        XCTAssertNil(wordBeforeInputResult(for: "word, ", ""))
    }


    func testSentenceDelimiterListReturnsStaticStringProperty() {
        XCTAssertEqual(proxy.sentenceDelimiters, String.sentenceDelimiters)
    }


    func testTrimmedDocumentContextAfterInputRemovesWhitespace() {
        proxy.documentContextAfterInput = " foo "
        XCTAssertEqual(proxy.trimmedDocumentContextAfterInput, "foo")
    }


    func testTrimmedDocumentContextBeforeInputRemovesWhitespace() {
        proxy.documentContextBeforeInput = " bar "
        XCTAssertEqual(proxy.trimmedDocumentContextBeforeInput, "bar")
    }


    func testWordDelimiterListReturnsStaticStringProperty() {
       XCTAssertEqual(proxy.wordDelimiters, String.wordDelimiters)
    }
}
#endif
