//
//  UITextDocumentProxy+QuotationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class UITextDocumentProxy_QuotationTests: XCTestCase {
    
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }


    func isOpenAlternateQuotationBeforeInputResult(for text: String?, locale: KeyboardLocale) -> Bool {
        proxy.documentContextBeforeInput = text
        return proxy.isOpenAlternateQuotationBeforeInput(for: locale.locale)
    }

    func testIsOpenAlternateQuotationBeforeInputIsFalseIfNoTextExistsBeforeCursor() {
        KeyboardLocale.allCases.forEach {
            XCTAssertFalse(isOpenAlternateQuotationBeforeInputResult(for: nil, locale: $0))
        }
    }

    func testIsOpenAlternateQuotationBeforeInputIsFalseIfTextBeforeCursorDoesNotContainBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding"
            XCTAssertFalse(isOpenAlternateQuotationBeforeInputResult(for: text, locale: $0))
        }
    }

    func testIsOpenAlternateQuotationBeforeInputIsFalseIfTextBeforeCursorHasEndDelimiterAfterBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding\($0.locale.alternateQuotationBeginDelimiter ?? "")\($0.locale.alternateQuotationEndDelimiter ?? "")"
            XCTAssertFalse(isOpenAlternateQuotationBeforeInputResult(for: text, locale: $0))
        }
    }

    func testIsOpenAlternateQuotationBeforeInputIsTrueIfTextBeforeCursorHasBeginDelimiterAfterEndDelimiter() {
        KeyboardLocale.allCases.forEach {
            let begin = $0.locale.alternateQuotationBeginDelimiter ?? ""
            let end = $0.locale.alternateQuotationEndDelimiter ?? ""
            let text = "I love coding\(end)\(begin)"
            let result = isOpenAlternateQuotationBeforeInputResult(for: text, locale: $0)
            XCTAssertEqual(result, begin != end)
        }
    }


    func isOpenQuotationBeforeInputResult(for text: String?, locale: KeyboardLocale) -> Bool {
        proxy.documentContextBeforeInput = text
        return proxy.isOpenQuotationBeforeInput(for: locale.locale)
    }

    func testIsOpenQuotationBeforeInputIsFalseIfNoTextExistsBeforeCursor() {
        KeyboardLocale.allCases.forEach {
            XCTAssertFalse(isOpenQuotationBeforeInputResult(for: nil, locale: $0))
        }
    }

    func testIsOpenQuotationBeforeInputIsFalseIfTextBeforeCursorDoesNotContainBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding"
            XCTAssertFalse(isOpenQuotationBeforeInputResult(for: text, locale: $0))
        }
    }

    func testIsOpenQuotationBeforeInputIsFalseIfTextBeforeCursorHasEndDelimiterAfterBeginDelimiter() {
        KeyboardLocale.allCases.forEach {
            let text = "I love coding\($0.locale.quotationBeginDelimiter ?? "")\($0.locale.quotationEndDelimiter ?? "")"
            XCTAssertFalse(isOpenQuotationBeforeInputResult(for: text, locale: $0))
        }
    }

    func testIsOpenQuotationBeforeInputIsTrueIfTextBeforeCursorHasBeginDelimiterAfterEndDelimiter() {
        KeyboardLocale.allCases.forEach {
            let begin = $0.locale.quotationBeginDelimiter ?? ""
            let end = $0.locale.quotationEndDelimiter ?? ""
            let text = "I love coding\(end)\(begin)"
            XCTAssertEqual(isOpenQuotationBeforeInputResult(for: text, locale: $0), begin != end)
        }
    }

    func testIsOpenQuotationBeforeInputIonorsSpecificLocaleScenarios() {
        XCTAssertTrue(isOpenQuotationBeforeInputResult(for: "This ‘Is me", locale: .dutch))
        XCTAssertTrue(isOpenQuotationBeforeInputResult(for: "This «Is me", locale: .italian))
        XCTAssertTrue(isOpenQuotationBeforeInputResult(for: "This «Is me", locale: .norwegian))
    }
}
#endif
