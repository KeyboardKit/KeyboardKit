//
//  UITextDocumentProxy+ReplaceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class UITextDocumentProxy_ReplaceTests: XCTestCase {

    var proxy: MockTextDocumentProxy!


    override func setUp() {
        proxy = MockTextDocumentProxy()
    }


    func result(for text: String?, locale: KeyboardLocale) -> String? {
        guard let text = text else { return nil }
        return proxy.preferredReplacement(for: text, locale: locale.locale)
    }

    func resultForEndDelimiter(for locale: KeyboardLocale) -> String? {
        let delimiter = locale.locale.quotationEndDelimiter
        return result(for: delimiter, locale: locale)
    }

    func resultForAltEndDelimiter(for locale: KeyboardLocale) -> String? {
        let delimiter = locale.locale.alternateQuotationEndDelimiter
        return result(for: delimiter, locale: locale)
    }

    func resultWithOpenEndDelimiter(for locale: KeyboardLocale) -> String? {
        proxy.documentContextBeforeInput = locale.locale.quotationBeginDelimiter
        return resultForEndDelimiter(for: locale)
    }

    func resultWithOpenAltEndDelimiter(for locale: KeyboardLocale) -> String? {
        proxy.documentContextBeforeInput = locale.locale.alternateQuotationBeginDelimiter
        return resultForAltEndDelimiter(for: locale)
    }


    func beginDelimiter(for locale: KeyboardLocale) -> String? {
        locale.locale.quotationBeginDelimiter
    }

    func altBeginDelimiter(for locale: KeyboardLocale) -> String? {
        locale.locale.alternateQuotationBeginDelimiter
    }


    func testPreferredReplacementForNonQuotationTest() {
        XCTAssertNil(result(for: "a", locale: .english))
    }


    func testPreferredReplacementWithNoOpenEndDelimiter() {
        proxy.documentContextBeforeInput = "before"

        XCTAssertEqual(resultForEndDelimiter(for: .danish), beginDelimiter(for: .danish))
        XCTAssertEqual(resultForEndDelimiter(for: .dutch), beginDelimiter(for: .dutch))
        XCTAssertEqual(resultForEndDelimiter(for: .english), beginDelimiter(for: .english))
        XCTAssertNil(resultForEndDelimiter(for: .finnish))
        XCTAssertEqual(result(for: "”", locale: .german), beginDelimiter(for: .german))
        XCTAssertEqual(resultForEndDelimiter(for: .german), beginDelimiter(for: .german))
        XCTAssertEqual(resultForEndDelimiter(for: .norwegian), beginDelimiter(for: .norwegian))
        XCTAssertNil(resultForEndDelimiter(for: .swedish))
    }

    func testPreferredReplacementWithNoOpenAltEndDelimiter() {
        proxy.documentContextBeforeInput = "before"
        XCTAssertEqual(resultForAltEndDelimiter(for: .danish), altBeginDelimiter(for: .danish))
        XCTAssertEqual(resultForAltEndDelimiter(for: .dutch), altBeginDelimiter(for: .dutch))
        XCTAssertEqual(resultForAltEndDelimiter(for: .english), altBeginDelimiter(for: .english))
        XCTAssertNil(resultForAltEndDelimiter(for: .finnish))
        XCTAssertEqual(resultForAltEndDelimiter(for: .german), altBeginDelimiter(for: .german))
        XCTAssertEqual(resultForAltEndDelimiter(for: .norwegian), altBeginDelimiter(for: .norwegian))
        XCTAssertNil(resultForAltEndDelimiter(for: .swedish))
    }


    func testPreferredReplacementWithOpenEndDelimiter() {
        XCTAssertNil(resultWithOpenEndDelimiter(for: .danish))
        XCTAssertNil(resultWithOpenEndDelimiter(for: .dutch))
        XCTAssertNil(resultWithOpenEndDelimiter(for: .english))
        XCTAssertNil(resultWithOpenEndDelimiter(for: .finnish))
        XCTAssertNil(resultWithOpenEndDelimiter(for: .norwegian))
        XCTAssertNil(resultWithOpenEndDelimiter(for: .swedish))
    }

    func testPreferredReplacementWithOpenAltEndDelimiter() {
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .danish))
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .dutch))
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .english))
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .finnish))
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .norwegian))
        XCTAssertNil(resultWithOpenAltEndDelimiter(for: .swedish))
    }
}
#endif
