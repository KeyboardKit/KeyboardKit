//
//  Locale+DirectionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-10.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_DirectionTests: XCTestCase {

    let english = Locale.english
    let persian = Locale.persian

    func testCharacterDirection() {
        func result(for locale: Locale) -> Locale.LanguageDirection {
            locale.characterDirection
        }
        XCTAssertEqual(result(for: english), .leftToRight)
        XCTAssertEqual(result(for: persian), .rightToLeft)
    }

    func testIsBottomToTop() {
        func result(for locale: Locale) -> Bool {
            locale.isBottomToTop
        }
        XCTAssertFalse(result(for: english))
        XCTAssertFalse(result(for: persian))
    }

    func testIsTopToBottom() {
        func result(for locale: Locale) -> Bool {
            locale.isTopToBottom
        }
        XCTAssertTrue(result(for: english))
        XCTAssertTrue(result(for: persian))
    }

    func testIsLeftToRight() {
        func resutl(for locale: Locale) -> Bool {
            locale.isLeftToRight
        }
        XCTAssertTrue(resutl(for: english))
        XCTAssertFalse(resutl(for: persian))
    }

    func testIsRightToLeft() {
        func result(for locale: Locale) -> Bool {
            locale.isRightToLeft
        }
        XCTAssertFalse(result(for: english))
        XCTAssertTrue(result(for: persian))
    }

    func testLineDirection() {
        func result(for locale: Locale) -> Locale.LanguageDirection {
            locale.lineDirection
        }
        XCTAssertEqual(result(for: english), .topToBottom)
        XCTAssertEqual(result(for: persian), .topToBottom)
    }
}
