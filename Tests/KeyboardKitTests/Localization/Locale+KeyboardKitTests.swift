//
//  Locale+KeyboardKitTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_KeyboardKitTests: XCTestCase {

    let locales = Locale.keyboardKitSupported

    func testDefinesKeyboardSupportedLocales() {
        XCTAssertEqual(locales.count, 72)
    }

    func testLocaleIdentifierIsValidForAllSupportedLocales() {
        let expected: [Locale: String] = [
            .albanian: "sq",
            .arabic: "ar",
            .armenian: "hy",
            .belarusian: "be",
            .bulgarian: "bg",
            .catalan: "ca",
            .cherokee: "chr",
            .chuvash: "cv",
            .croatian: "hr",
            .czech: "cs",
            .danish: "da",
            .dutch: "nl",
            .dutch_belgium: "nl_BE",
            .english: "en",
            .english_australia: "en_AU",
            .english_canada: "en_CA",
            .english_gb: "en_GB",
            .english_us: "en_US",
            .estonian: "et",
            .faroese: "fo",
            .filipino: "fil",
            .finnish: "fi",
            .french: "fr",
            .french_belgium: "fr_BE",
            .french_canada: "fr_CA",
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
            .inari_sami: "smn",
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
            .northern_sami: "se",
            .norwegian: "nb",
            .norwegian_nynorsk: "nn",
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
            .spanish_latinAmerica: "es_419",
            .spanish_mexico: "es_MX",
            .swahili: "sw",
            .swedish: "sv",
            .turkish: "tr",
            .ukrainian: "uk",
            .uzbek: "uz",
            .vietnamese: "vi",
            .welsh: "cy"
        ]

        XCTAssertEqual(expected.keys.count, locales.count)
        expected.keys.forEach {
            XCTAssertEqual(expected[$0], $0.identifier)
        }
    }
}
