//
//  LocaleAnalyzerProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class LocaleAnalyzerProviderTests: XCTestCase {

    func characterDirection(of localeId: String) -> Locale.LanguageDirection {
        let locale = Locale(identifier: localeId)
        return locale.characterDirection
    }

    func testCharacterDirectionIsValid() {
        XCTAssertEqual(characterDirection(of: "en"), .leftToRight)
        XCTAssertEqual(characterDirection(of: "fa"), .rightToLeft)
        XCTAssertEqual(characterDirection(of: "zh_Hant_TW"), .leftToRight)
    }


    func lineDirection(of localeId: String) -> Locale.LanguageDirection {
        let locale = Locale(identifier: localeId)
        return locale.lineDirection
    }

    func testLineDirectionIsValid() {
        XCTAssertEqual(lineDirection(of: "en"), .topToBottom)
        XCTAssertEqual(lineDirection(of: "fa"), .topToBottom)
        XCTAssertEqual(lineDirection(of: "zh_Hant_TW"), .topToBottom)
    }


    func isBottomToTop(_ localeId: String) -> Bool {
        let locale = Locale(identifier: localeId)
        return locale.isBottomToTop
    }

    func testIsBottomToTopIsValid() {
        XCTAssertEqual(isBottomToTop("en"), false)
        XCTAssertEqual(isBottomToTop("fa"), false)
        XCTAssertEqual(isBottomToTop("zh_Hant_TW"), false)
    }


    func isTopToBottom(_ localeId: String) -> Bool {
        let locale = Locale(identifier: localeId)
        return locale.isTopToBottom
    }

    func testIsTopToBottomIsValid() {
        XCTAssertEqual(isTopToBottom("en"), true)
        XCTAssertEqual(isTopToBottom("fa"), true)
        XCTAssertEqual(isTopToBottom("zh_Hant_TW"), true)
    }


    func isLeftToRight(_ localeId: String) -> Bool {
        let locale = Locale(identifier: localeId)
        return locale.isLeftToRight
    }

    func testIsLeftToRightIsValid() {
        XCTAssertEqual(isLeftToRight("en"), true)
        XCTAssertEqual(isLeftToRight("fa"), false)
        XCTAssertEqual(isLeftToRight("zh_Hant_TW"), true)
    }


    func isRightToLeft(_ localeId: String) -> Bool {
        let locale = Locale(identifier: localeId)
        return locale.isRightToLeft
    }

    func testIsRightToLeftIsValid() {
        XCTAssertEqual(isRightToLeft("en"), false)
        XCTAssertEqual(isRightToLeft("fa"), true)
        XCTAssertEqual(isRightToLeft("zh_Hant_TW"), false)
    }
}
