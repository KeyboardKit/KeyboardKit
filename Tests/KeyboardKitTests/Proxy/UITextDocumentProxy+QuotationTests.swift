//
//  UITextDocumentProxy+QuotationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import XCTest

class UITextDocumentProxy_QuotationTests: XCTestCase {

    var proxy: MockTextDocumentProxy!

    let locales = Locale.keyboardKitSupported

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }


    // MARK: - Unclosed alternate quotation

    func hasUnclosedAlternateQuotation(
        _ text: String?,
        locale: Locale
    ) -> Bool {
        proxy.documentContextBeforeInput = text
        let result = proxy.hasUnclosedAlternateQuotationBeforeInput(for: locale)
        return result
    }

    func testHasUnclosedAlternateQuotationIsFalseIfNoTextExists() {
        locales.forEach {
            XCTAssertFalse(hasUnclosedAlternateQuotation(nil, locale: $0))
        }
    }

    func testHasUnclosedAlternateQuotationIsFalseIfTextDoesNotContainDelimiters() {
        locales.forEach {
            let text = "I love coding"
            XCTAssertFalse(hasUnclosedAlternateQuotation(text, locale: $0))
        }
    }

    func testHasUnclosedAlternateQuotationIsTrueIfLastDelimiterIsBeginDelimiter() {
        locales.forEach {
            let begin = $0.alternateQuotationBeginDelimiter ?? ""
            let end = $0.alternateQuotationEndDelimiter ?? ""
            XCTAssertEqual(hasUnclosedAlternateQuotation("I love coding\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedAlternateQuotation("I love coding\(end)", locale: $0))
            XCTAssertEqual(hasUnclosedAlternateQuotation("I love coding\(end)\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedAlternateQuotation("I love coding\(begin)\(end)", locale: $0))
        }
    }


    // MARK: - Unclosed quotation

    func hasUnclosedQuotation(
        _ text: String?,
        locale: Locale
    ) -> Bool {
        proxy.documentContextBeforeInput = text
        let result = proxy.hasUnclosedQuotationBeforeInput(for: locale)
        return result
    }

    func testHasUnclosedQuotationIsFalseIfNoTextExists() {
        locales.forEach {
            XCTAssertFalse(hasUnclosedQuotation(nil, locale: $0))
        }
    }

    func testHasUnclosedQuotationIsFalseIfTextDoesNotContainDelimiters() {
        locales.forEach {
            let text = "I love coding"
            XCTAssertFalse(hasUnclosedQuotation(text, locale: $0))
        }
    }

    func testHasUnclosedQuotationIsTrueIfLastDelimiterIsBeginDelimiter() {
        locales.forEach {
            let begin = $0.quotationBeginDelimiter ?? ""
            let end = $0.quotationEndDelimiter ?? ""
            XCTAssertEqual(hasUnclosedQuotation("I love coding\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedQuotation("I love coding\(end)", locale: $0))
            XCTAssertEqual(hasUnclosedQuotation("I love coding\(end)\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedQuotation("I love coding\(begin)\(end)", locale: $0))
        }
    }

    func testHasUnclosedQuotationHonorsLocalseSpecificCases() {
        XCTAssertTrue(hasUnclosedQuotation("This ‘Is me", locale: .dutch))
        XCTAssertTrue(hasUnclosedQuotation("This «Is me", locale: .italian))
        XCTAssertTrue(hasUnclosedQuotation("This «Is me", locale: .norwegian))
    }


    // MARK: - Preferred quotation replacement

    func beginDelimiter(for locale: Locale) -> String {
        locale.quotationBeginDelimiter ?? ""
    }

    func altBeginDelimiter(for locale: Locale) -> String {
        locale.alternateQuotationBeginDelimiter ?? ""
    }

    func endDelimiter(for locale: Locale) -> String {
        locale.quotationEndDelimiter ?? ""
    }

    func altEndDelimiter(for locale: Locale) -> String {
        locale.alternateQuotationEndDelimiter ?? ""
    }

    func testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for locale: Locale, delimiter: String? = nil, expected: String?) {
        let text = "before"
        proxy.documentContextBeforeInput = text
        let delimiter = delimiter ?? endDelimiter(for: locale)
        let proxyResult = proxy.preferredQuotationReplacement(whenInserting: delimiter, for: locale)
        XCTAssertEqual(proxyResult, expected)
    }

    func testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter() {
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .danish, expected: beginDelimiter(for: .danish))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .dutch, expected: beginDelimiter(for: .dutch))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .english, expected: beginDelimiter(for: .english))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .finnish, expected: nil)
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .german, delimiter: "”", expected: beginDelimiter(for: .german))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .german, expected: beginDelimiter(for: .german))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .norwegian, expected: beginDelimiter(for: .norwegian))
        testPreferredQuotationReplacementWhenInsertingEndDelimiterWithoutUnclosedBeginDelimiter(for: .swedish, expected: nil)
    }

    func testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(
        for locale: Locale,
        delimiter: String? = nil,
        expected: String?
    ) {
        let text = "before"
        proxy.documentContextBeforeInput = text
        let delimiter = delimiter ?? altEndDelimiter(for: locale)
        let proxyResult = proxy.preferredQuotationReplacement(whenInserting: delimiter, for: locale)
        XCTAssertEqual(proxyResult, expected)
    }

    func testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter() {
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .danish, expected: altBeginDelimiter(for: .danish))
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .dutch, expected: altBeginDelimiter(for: .dutch))
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .english, expected: nil)
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .finnish, expected: nil)
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .german, expected: altBeginDelimiter(for: .german))
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .german, expected: altBeginDelimiter(for: .german))
        testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterWithoutUnclosedBeginDelimiter(for: .swedish, expected: nil)
    }

    func testPreferredQuotationReplacementWhenInsertingEndDelimiterAfterUnclosedBeginDelimiter() {
        locales.forEach {
            let text = "text with some \(beginDelimiter(for: $0))quoted text"
            let insert = endDelimiter(for: $0)
            proxy.documentContextBeforeInput = text
            XCTAssertNil(proxy.preferredQuotationReplacement(whenInserting: insert, for: $0))
        }
    }

    func testPreferredQuotationReplacementWhenInsertingAlternateEndDelimiterAfterUnclosedBeginDelimiter() {
        locales.forEach {
            let text = "text with some \(altBeginDelimiter(for: $0))quoted text"
            let insert = altEndDelimiter(for: $0)
            proxy.documentContextBeforeInput = text
            XCTAssertNil(proxy.preferredQuotationReplacement(whenInserting: insert, for: $0))
        }
    }
}
#endif
