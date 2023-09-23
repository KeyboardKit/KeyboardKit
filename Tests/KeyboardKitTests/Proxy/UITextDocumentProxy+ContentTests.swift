//
//  UITextDocumentProxy+ContentTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import XCTest
@testable import KeyboardKit

class UITextDocumentProxy_ContentTests: XCTestCase {
    
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }

    func prepareProxy(with preCursorPart: String, _ postCursorPart: String? = nil) {
        proxy.documentContextBeforeInput = preCursorPart
        proxy.documentContextAfterInput = postCursorPart
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


    func testWordDelimiterListReturnsStaticStringProperty() {
       XCTAssertEqual(proxy.wordDelimiters, String.wordDelimiters)
    }
}
#endif
