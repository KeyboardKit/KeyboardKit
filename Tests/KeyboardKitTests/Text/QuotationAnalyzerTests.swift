//
//  QuotationAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class QuotationAnalyzerTests: XCTestCase {

    class Analyzer: QuotationAnalyzer {}

    var analyzer: Analyzer!
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        analyzer = Analyzer()
        proxy = MockTextDocumentProxy()
    }


    func hasUnclosedAlternateQuotation(_ text: String?, locale: KeyboardLocale) -> Bool {
        proxy.documentContextBeforeInput = text
        let staticCheck = analyzer.hasUnclosedAlternateQuotation(in: text ?? "", for: locale.locale)
        let instanceCheck = text?.hasUnclosedAlternateQuotation(for: locale.locale) ?? false
        let proxyCheck = proxy.hasUnclosedAlternateQuotationBeforeInput(for: locale.locale)
        return staticCheck && instanceCheck && proxyCheck
    }

    func testHasUnclosedAlternateQuotationIsFalseIfNoTextExists() {
        KeyboardLocale.allCases.forEach {
            XCTAssertFalse(hasUnclosedAlternateQuotation(nil, locale: $0))
        }
    }

    func testHasUnclosedAlternateQuotationIsFalseIfTextDoesNotContainDelimiters() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding"
            XCTAssertFalse(hasUnclosedAlternateQuotation(text, locale: $0))
        }
    }

    func testHasUnclosedAlternateQuotationIsTrueIfLastDelimiterIsBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let begin = $0.locale.alternateQuotationBeginDelimiter ?? ""
            let end = $0.locale.alternateQuotationEndDelimiter ?? ""
            XCTAssertEqual(hasUnclosedAlternateQuotation("I love coding\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedAlternateQuotation("I love coding\(end)", locale: $0))
            XCTAssertEqual(hasUnclosedAlternateQuotation("I love coding\(end)\(begin)", locale: $0), begin != end)
            XCTAssertFalse(hasUnclosedAlternateQuotation("I love coding\(begin)\(end)", locale: $0))
        }
    }


    func hasUnclosedQuotation(_ text: String?, locale: KeyboardLocale) -> Bool {
        proxy.documentContextBeforeInput = text
        let staticCheck = analyzer.hasUnclosedQuotation(in: text ?? "", for: locale.locale)
        let instanceCheck = text?.hasUnclosedQuotation(for: locale.locale) ?? false
        let proxyCheck = proxy.hasUnclosedQuotationBeforeInput(for: locale.locale)
        return staticCheck && instanceCheck && proxyCheck
    }

    func testHasUnclosedQuotationIsFalseIfNoTextExists() {
        KeyboardLocale.allCases.forEach {
            XCTAssertFalse(hasUnclosedQuotation(nil, locale: $0))
        }
    }

    func testHasUnclosedQuotationIsFalseIfTextDoesNotContainDelimiters() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding"
            XCTAssertFalse(hasUnclosedQuotation(text, locale: $0))
        }
    }

    func testHasUnclosedQuotationIsTrueIfLastDelimiterIsBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let begin = $0.locale.quotationBeginDelimiter ?? ""
            let end = $0.locale.quotationEndDelimiter ?? ""
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
}
#endif
