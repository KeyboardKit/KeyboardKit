//
//  KeyboardLocaleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocaleTests: XCTestCase {
    
    let locales = KeyboardLocale.allCases

    func locale(_ locale: KeyboardLocale) -> KeyboardLocale { locale }

    func testLocaleIdentifierIsValidForAllCases() {
        XCTAssertEqual(KeyboardLocale.allCases.count, 61)

        let map = locales.map { ($0, $0.locale.identifier) }
        let result = Dictionary(uniqueKeysWithValues: map)
        let expected: [KeyboardLocale: String] = [
            .albanian: "sq",
            .arabic: "ar",
            .armenian: "hy",
            .belarusian: "be",
            .bulgarian: "bg",
            .catalan: "ca",
            .cherokee: "chr",
            .croatian: "hr",
            .czech: "cs",
            .danish: "da",
            .dutch: "nl",
            .dutch_belgium: "nl_BE",
            .english: "en",
            .english_gb: "en_GB",
            .english_us: "en_US",
            .estonian: "et",
            .faroese: "fo",
            .filipino: "fil",
            .finnish: "fi",
            .french: "fr",
            .french_belgium: "fr_BE",
            .french_switzerland: "fr_CH",
            .georgian: "ka",
            .german: "de",
            .german_austria: "de_AT",
            .german_switzerland: "de_CH",
            .greek: "el",
            .hawaiian: "haw",
            .hebrew: "he_IL",
            .hungarian: "hu",
            .icelandic: "is",
            .indonesian: "id",
            .irish: "ga_IE",
            .italian: "it",
            .kazakh: "kk",
            .kurdish_sorani: "ckb",
            .kurdish_sorani_arabic: "ckb_IQ",
            .kurdish_sorani_pc: "ckb_PC",
            .latvian: "lv",
            .lithuanian: "lt",
            .macedonian: "mk",
            .malay: "ms",
            .maltese: "mt",
            .mongolian: "mn",
            .norwegian: "nb",
            .persian: "fa",
            .polish: "pl",
            .portuguese: "pt_PT",
            .portuguese_brazil: "pt_BR",
            .romanian: "ro",
            .russian: "ru",
            .serbian: "sr",
            .serbian_latin: "sr-Latn",
            .slovenian: "sl",
            .slovak: "sk",
            .spanish: "es",
            .swahili: "sw",
            .swedish: "sv",
            .turkish: "tr",
            .ukrainian: "uk",
            .uzbek: "uz"
        ]

        XCTAssertEqual(result.keys, expected.keys)
        result.keys.forEach {
            XCTAssertEqual(result[$0], expected[$0])
        }
    }

    func testLocaleIdentifierIsIdenticalToEnumId() {
        let map = locales.map { ($0, $0.id == $0.localeIdentifier) }
        let result = Dictionary(uniqueKeysWithValues: map)
        XCTAssertTrue(result.allSatisfy { $0.value == true })
    }

    func testEmbeddedLocaleIdentifierIsIdenticalToEnumId() {
        let map = locales.map { ($0, $0.id == $0.locale.identifier) }
        let result = Dictionary(uniqueKeysWithValues: map)
        XCTAssertTrue(result.allSatisfy { $0.value == true })
    }

    func testFlagIsValidForAllCases() {
        let map = locales.map { ($0, $0.flag) }
        let result = Dictionary(uniqueKeysWithValues: map)
        let expected: [KeyboardLocale: String] = [
            .albanian: "🇦🇱",
            .arabic: "🇦🇪",
            .armenian: "🇦🇲",
            .belarusian: "🇧🇾",
            .bulgarian: "🇧🇬",
            .catalan: "🇦🇩",
            .cherokee: "🏳️",
            .croatian: "🇭🇷",
            .czech: "🇨🇿",
            .danish: "🇩🇰",
            .dutch: "🇳🇱",
            .dutch_belgium: "🇧🇪",
            .english: "🇺🇸",
            .english_gb: "🇬🇧",
            .english_us: "🇺🇸",
            .estonian: "🇪🇪",
            .faroese: "🇫🇴",
            .filipino: "🇵🇭",
            .finnish: "🇫🇮",
            .french: "🇫🇷",
            .french_belgium: "🇧🇪",
            .french_switzerland: "🇨🇭",
            .georgian: "🇬🇪",
            .german: "🇩🇪",
            .german_austria: "🇦🇹",
            .german_switzerland: "🇨🇭",
            .greek: "🇬🇷",
            .hawaiian: "🇺🇸",
            .hebrew: "🇮🇱",
            .hungarian: "🇭🇺",
            .icelandic: "🇮🇸",
            .indonesian: "🇮🇩",
            .irish: "🇮🇪",
            .italian: "🇮🇹",
            .kazakh: "🇰🇿",
            .kurdish_sorani: "🇹🇯",
            .kurdish_sorani_arabic: "🇹🇯",
            .kurdish_sorani_pc: "🇹🇯",
            .latvian: "🇱🇻",
            .lithuanian: "🇱🇹",
            .macedonian: "🇲🇰",
            .malay: "🇲🇾",
            .maltese: "🇲🇹",
            .mongolian: "🇲🇳",
            .norwegian: "🇳🇴",
            .persian: "🇮🇷",
            .polish: "🇵🇱",
            .portuguese: "🇵🇹",
            .portuguese_brazil: "🇧🇷",
            .romanian: "🇷🇴",
            .russian: "🇷🇺",
            .serbian: "🇷🇸",
            .serbian_latin: "🇷🇸",
            .slovenian: "🇸🇮",
            .slovak: "🇸🇰",
            .spanish: "🇪🇸",
            .swedish: "🇸🇪",
            .swahili: "🇰🇪",
            .turkish: "🇹🇷",
            .ukrainian: "🇺🇦",
            .uzbek: "🇺🇿"
        ]

        XCTAssertEqual(result.keys, expected.keys)
        result.keys.forEach {
            XCTAssertEqual(result[$0], expected[$0])
        }
    }


    func testInsertingFirstReturnsValidArray() {
        let locales: [KeyboardLocale] = [.finnish, .hungarian]
        let result = locales.insertingFirst(.swedish)
        XCTAssertEqual(result, [.swedish, .finnish, .hungarian])
    }

    func testInsertingFirstRemovesDuplicates() {
        let locales: [KeyboardLocale] = [.finnish, .hungarian]
        let result = locales.insertingFirst(.hungarian)
        XCTAssertEqual(result, [.hungarian, .finnish])
    }


    func testRemovingReturnsValidArray() {
        let locales: [KeyboardLocale] = [.finnish, .hungarian]
        let result = locales.removing(.hungarian)
        XCTAssertEqual(result, [.finnish])
    }

    func testRemovingDoesNothingIfLocaleIsMissing() {
        let locales: [KeyboardLocale] = [.finnish, .hungarian]
        let result = locales.removing(.swedish)
        XCTAssertEqual(result, [.finnish, .hungarian])
    }


    func testSortedUsesTheStandardLocalizedNameByDefault() {
        let locales = [
            locale(.finnish),   // fi, soumi  (last)
            locale(.hungarian)  // hu, magyar (first)
        ]
        let result = locales.sorted()
        let ids = result.map { $0.id }
        XCTAssertEqual(ids, ["hu", "fi"])
    }

    func testSortedInLocaleUsesTheLocaleLocalizedName() {
        let locales = [
            locale(.finnish),   // fi, Finnish (first)
            locale(.hungarian)  // hu, Hungarian (last)
        ]
        let result = locales.sorted(in: locale(.english).locale)
        let ids = result.map { $0.id }
        XCTAssertEqual(ids, ["fi", "hu"])
    }
}
