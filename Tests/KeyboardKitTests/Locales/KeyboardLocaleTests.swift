//
//  KeyboardLocaleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLocaleTests: XCTestCase {
    
    let locales = KeyboardLocale.allCases

    func testLocaleIdentifierIsValidForAllCases() {
        XCTAssertEqual(KeyboardLocale.allCases.count, 60)

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

    func testLocalizedNameIsValidForAllCases() {
        let map = locales.map { ($0, $0.localizedName) }
        let result = Dictionary(uniqueKeysWithValues: map)
        let expected: [KeyboardLocale: String] = [
            .albanian: "shqip",
            .arabic: "العربية",
            .armenian: "հայերեն",
            .belarusian: "беларуская",
            .bulgarian: "български",
            .dutch_belgium: "Nederlands (België)",
            .catalan: "català",
            .cherokee: "ᏣᎳᎩ",
            .croatian: "hrvatski",
            .czech: "čeština",
            .danish: "dansk",
            .dutch: "Nederlands",
            .english: "English",
            .english_gb: "English (United Kingdom)",
            .english_us: "English (United States)",
            .estonian: "eesti",
            .faroese: "føroyskt",
            .filipino: "Filipino",
            .finnish: "suomi",
            .french: "français",
            .french_belgium: "français (Belgique)",
            .french_switzerland: "français (Suisse)",
            .georgian: "ქართული",
            .german: "Deutsch",
            .german_austria: "Deutsch (Österreich)",
            .german_switzerland: "Deutsch (Schweiz)",
            .greek: "Ελληνικά",
            .hawaiian: "ʻŌlelo Hawaiʻi",
            .hebrew: "עברית (ישראל)",
            .hungarian: "magyar",
            .icelandic: "íslenska",
            .indonesian: "Indonesia",
            .irish: "Gaeilge (Éire)",
            .italian: "italiano",
            .kurdish_sorani: "کوردیی ناوەندی",
            .kurdish_sorani_arabic: "کوردیی ناوەندی (عێراق)",
            .kurdish_sorani_pc: "کوردیی ناوەندی" + " (PC)",
            .latvian: "latviešu",
            .lithuanian: "lietuvių",
            .macedonian: "македонски",
            .malay: "Bahasa Melayu",
            .maltese: "Malti",
            .mongolian: "монгол",
            .norwegian: "norsk bokmål",
            .persian: "فارسی",
            .polish: "polski",
            .portuguese: "português (Portugal)",
            .portuguese_brazil: "português (Brasil)",
            .romanian: "română",
            .russian: "русский",
            .serbian: "српски",
            .serbian_latin: "srpski (latinica)",
            .slovenian: "slovenščina",
            .slovak: "slovenčina",
            .spanish: "español",
            .swahili: "Kiswahili",
            .swedish: "svenska",
            .turkish: "Türkçe",
            .ukrainian: "українська",
            .uzbek: "o‘zbek"]

        XCTAssertEqual(result.keys, expected.keys)
        result.keys.forEach {
            XCTAssertEqual(result[$0], expected[$0])
        }
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

    func testIsLtrIsDerivedFromResolvedLocale() {
        locales.forEach {
            XCTAssertEqual($0.isLeftToRight, $0.locale.isLeftToRight)
        }
    }

    func testIsRtlIsDerivedFromResolvedLocale() {
        locales.forEach {
            XCTAssertEqual($0.isRightToLeft, $0.locale.isRightToLeft)
        }
    }

    func testPrefersAlternateQuotationReplacementIsDerivedFromResolvedLocale() {
        locales.forEach {
            XCTAssertEqual($0.prefersAlternateQuotationReplacement, $0.locale.prefersAlternateQuotationReplacement)
        }
    }

    func testSortedIsSortedByLocalizedName() {
        let locales = KeyboardLocale.allCases.sorted()
        let names = locales.map { $0.localizedName.capitalized }
        XCTAssertTrue(names.contains("Dansk"))
        XCTAssertTrue(names.contains("Svenska"))
        XCTAssertNotEqual(names[0], "English")
    }

    func testSortedCanInsertEistingLocaleFirstmost() {
        let locales = KeyboardLocale.allCases.sorted(insertFirst: .english)
        let names = locales.map { $0.localizedName.capitalized }
        XCTAssertTrue(names.contains("Dansk"))
        XCTAssertTrue(names.contains("Svenska"))
        XCTAssertEqual(names[0], "English")
    }
}
