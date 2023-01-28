//
//  KeyboardCharacterProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardCharacterProviderTests: XCTestCase {

    class Provider: KeyboardCharacterProvider {}

    let provider = Provider()

    func testProvidersCanAccessStringExtensions() {
        XCTAssertEqual(provider.carriageReturn, String.carriageReturn)
        XCTAssertEqual(provider.newline, String.newline)
        XCTAssertEqual(provider.space, String.space)
        XCTAssertEqual(provider.tab, String.tab)
        XCTAssertEqual(provider.zeroWidthSpace, String.zeroWidthSpace)
        XCTAssertEqual(provider.carriageReturn, String.carriageReturn)
        XCTAssertEqual(provider.newline, String.newline)
    }

    func testStringExtensionsAreDefined() {
        XCTAssertEqual(String.carriageReturn, "\r")
        XCTAssertEqual(String.newline, "\n")
        XCTAssertEqual(String.space, " ")
        XCTAssertEqual(String.tab, "\t")
        XCTAssertEqual(String.zeroWidthSpace, "\u{200B}")

        XCTAssertEqual(String.sentenceDelimiters, ["!", ".", "?"])
        XCTAssertEqual(String.wordDelimiters, "!.?,;:()[]{}<>".chars + [" ", .newline])

        XCTAssertEqual([String].sentenceDelimiters, String.sentenceDelimiters)
        XCTAssertEqual([String].wordDelimiters, String.wordDelimiters)
    }

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
