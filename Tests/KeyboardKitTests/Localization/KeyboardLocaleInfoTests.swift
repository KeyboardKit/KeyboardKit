//
//  KeyboardLocaleInfoTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocaleInfoTests: XCTestCase {

    func testCharacterDirection() {
        func value(for locale: KeyboardLocaleInfo) -> Locale.LanguageDirection {
            locale.characterDirection
        }

        XCTAssertEqual(value(for: KeyboardLocale.english), .leftToRight)
        XCTAssertEqual(value(for: KeyboardLocale.persian), .rightToLeft)

        XCTAssertEqual(value(for: KeyboardLocale.english.locale), .leftToRight)
        XCTAssertEqual(value(for: KeyboardLocale.persian.locale), .rightToLeft)
    }

    func testIsBottomToTop() {
        func value(for locale: KeyboardLocaleInfo) -> Bool {
            locale.isBottomToTop
        }

        XCTAssertFalse(value(for: KeyboardLocale.english))
        XCTAssertFalse(value(for: KeyboardLocale.persian))
    }

    func testIsTopToBottom() {
        func value(for locale: KeyboardLocaleInfo) -> Bool {
            locale.isTopToBottom
        }

        XCTAssertTrue(value(for: KeyboardLocale.english))
        XCTAssertTrue(value(for: KeyboardLocale.persian))
    }

    func testIsLeftToRight() {
        func value(for locale: KeyboardLocaleInfo) -> Bool {
            locale.isLeftToRight
        }

        XCTAssertTrue(value(for: KeyboardLocale.english))
        XCTAssertFalse(value(for: KeyboardLocale.persian))
    }

    func testIsRightToLeft() {
        func value(for locale: KeyboardLocaleInfo) -> Bool {
            locale.isRightToLeft
        }

        XCTAssertFalse(value(for: KeyboardLocale.english))
        XCTAssertTrue(value(for: KeyboardLocale.persian))
    }

    func testLineDirection() {
        func value(for locale: KeyboardLocaleInfo) -> Locale.LanguageDirection {
            locale.lineDirection
        }

        XCTAssertEqual(value(for: KeyboardLocale.english), .topToBottom)
        XCTAssertEqual(value(for: KeyboardLocale.persian), .topToBottom)

        XCTAssertEqual(value(for: KeyboardLocale.english.locale), .topToBottom)
        XCTAssertEqual(value(for: KeyboardLocale.persian.locale), .topToBottom)
        XCTAssertEqual(value(for: Locale(identifier: "zh_Hant_TW")), .topToBottom)
    }

    func testPrefersAlternateQuotationReplacement() {
        func value(for locale: KeyboardLocaleInfo) -> Bool {
            locale.prefersAlternateQuotationReplacement
        }

        XCTAssertFalse(value(for: KeyboardLocale.english))
        XCTAssertTrue(value(for: KeyboardLocale.swedish))

        XCTAssertFalse(value(for: KeyboardLocale.english.locale))
        XCTAssertTrue(value(for: KeyboardLocale.swedish.locale))
    }
}
