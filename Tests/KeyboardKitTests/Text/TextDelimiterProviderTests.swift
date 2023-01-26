//
//  TextDelimiterProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class TextDelimiterProviderTests: XCTestCase {

    let sentenceDelimiters = TextDelimiters.sentenceDelimiters
    let wordDelimiters = TextDelimiters.wordDelimiters

    func testProvidersCanAccessSentenceDelimiters() {
        let expected = sentenceDelimiters
        XCTAssertEqual(String.sentenceDelimiters, expected)
        XCTAssertEqual("".sentenceDelimiters, expected)
    }

    func testProvidersCanAccessWordDelimiters() {
        let expected = wordDelimiters
        XCTAssertEqual(String.wordDelimiters, expected)
        XCTAssertEqual("".wordDelimiters, expected)
    }

    #if os(iOS) || os(tvOS)
    func testTextDocumentProxyCanAccessSentenceDelimiters() {
        let proxy = MockTextDocumentProxy()
        XCTAssertEqual(proxy.sentenceDelimiters, sentenceDelimiters)
        XCTAssertEqual(proxy.wordDelimiters, wordDelimiters)
    }
    #endif
    
    func testStringCanIdentifyAsSentenceDelimiter() {
        let result = String.sentenceDelimiters.map { $0.isSentenceDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isSentenceDelimiter)
    }

    func testStringCanIdentifyAsWordDelimiter() {
        let result = String.wordDelimiters.map { $0.isWordDelimiter }
        XCTAssertTrue(result.allSatisfy { $0 == true })
        XCTAssertFalse("a".isWordDelimiter)
    }
}
