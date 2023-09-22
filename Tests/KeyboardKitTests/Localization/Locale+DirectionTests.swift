//
//  Locale+DirectionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_DirectionTests: XCTestCase {

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

    func testTextDirectionIsValidForAllKeyboardLocales() {
        let map = KeyboardLocale.allCases.map { ($0, ($0.locale.isLeftToRight, $0.locale.isRightToLeft)) }
        let result = Dictionary(uniqueKeysWithValues: map)
        let expected: [KeyboardLocale: (Bool, Bool)] = [
            .albanian: (true, false),
            .arabic: (false, true),
            .armenian: (true, false),
            .belarusian: (true, false),
            .bulgarian: (true, false),
            .dutch_belgium: (true, false),
            .catalan: (true, false),
            .cherokee: (true, false),
            .croatian: (true, false),
            .czech: (true, false),
            .danish: (true, false),
            .dutch: (true, false),
            .english: (true, false),
            .english_gb: (true, false),
            .english_us: (true, false),
            .estonian: (true, false),
            .faroese: (true, false),
            .filipino: (true, false),
            .finnish: (true, false),
            .french: (true, false),
            .french_belgium: (true, false),
            .french_switzerland: (true, false),
            .georgian: (true, false),
            .german: (true, false),
            .german_austria: (true, false),
            .german_switzerland: (true, false),
            .greek: (true, false),
            .hawaiian: (true, false),
            .hebrew: (false, true),
            .hungarian: (true, false),
            .icelandic: (true, false),
            .indonesian: (true, false),
            .irish: (true, false),
            .italian: (true, false),
            .kazakh: (true, false),
            .kurdish_sorani: (false, true),
            .kurdish_sorani_arabic: (false, true),
            .kurdish_sorani_pc: (false, true),
            .latvian: (true, false),
            .lithuanian: (true, false),
            .macedonian: (true, false),
            .malay: (true, false),
            .maltese: (true, false),
            .mongolian: (true, false),
            .norwegian: (true, false),
            .persian: (false, true),
            .polish: (true, false),
            .portuguese: (true, false),
            .portuguese_brazil: (true, false),
            .romanian: (true, false),
            .russian: (true, false),
            .serbian: (true, false),
            .serbian_latin: (true, false),
            .slovenian: (true, false),
            .slovak: (true, false),
            .spanish: (true, false),
            .swahili: (true, false),
            .swedish: (true, false),
            .turkish: (true, false),
            .ukrainian: (true, false),
            .uzbek: (true, false)
        ]

        XCTAssertEqual(result.keys, expected.keys)
        result.keys.forEach {
            XCTAssertEqual(result[$0]?.0, expected[$0]?.0)
            XCTAssertEqual(result[$0]?.1, expected[$0]?.1)
        }
    }
}
