//
//  Locale+NameTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_NameTests: XCTestCase {

    func locale(_ localeId: String) -> Locale {
        Locale(identifier: localeId)
    }

    func locale(_ locale: KeyboardLocale) -> Locale {
        locale.locale
    }

    func localizedName(of localeId: String) -> String? {
        locale(localeId).localizedName
    }

    func testLocalizedNameIsValid() {
        XCTAssertEqual(localizedName(of: "en"), "English")
        XCTAssertEqual(localizedName(of: "en-GB"), "English (United Kingdom)")
        XCTAssertEqual(localizedName(of: "en-US"), "English (United States)")
        XCTAssertEqual(localizedName(of: "sv"), "svenska")
    }

    
    func testLocalizedNameIsValidForAllKeyboardLocales() {
        let map = KeyboardLocale.allCases.map { ($0, $0.locale.localizedName) }
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
            .kazakh: "қазақ тілі",
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


    func nameOfSwedish(in localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedName(in: locale)
    }

    func testLocalizedNameInLocaleIsValid() {
        XCTAssertEqual(nameOfSwedish(in: "en"), "Swedish (Sweden)")
        XCTAssertEqual(nameOfSwedish(in: "fi"), "ruotsi (Ruotsi)")
        XCTAssertEqual(nameOfSwedish(in: "no"), "svensk (Sverige)")
        XCTAssertEqual(nameOfSwedish(in: "sv"), "svenska (Sverige)")
    }


    func localizedLanguageName(of localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        return locale.localizedLanguageName
    }

    func testLocalizedLanguageNameIsValid() {
        XCTAssertEqual(localizedLanguageName(of: "en"), "English")
        XCTAssertEqual(localizedLanguageName(of: "en-GB"), "English")
        XCTAssertEqual(localizedLanguageName(of: "en-US"), "English")
        XCTAssertEqual(localizedLanguageName(of: "sv"), "svenska")
    }


    func nameOfSwedishLanguage(in localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedLanguageName(in: locale)
    }

    func testLocalizedLanguageNameInLocaleIsValid() {
        XCTAssertEqual(nameOfSwedishLanguage(in: "en"), "Swedish")
        XCTAssertEqual(nameOfSwedishLanguage(in: "fi"), "ruotsi")
        XCTAssertEqual(nameOfSwedishLanguage(in: "no"), "svensk")
        XCTAssertEqual(nameOfSwedishLanguage(in: "sv"), "svenska")
    }



    func testSortedUsesTheStandardLocalizedNameByDefault() {
        let locales = [
            locale(.finnish),   // fi, soumi  (last)
            locale(.hungarian)  // hu, magyar (first)
        ]
        let result = locales.sorted()
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["hu", "fi"])
    }

    func testSortedCanPlaceLocaleFirst() {
        let locales = [
            locale(.finnish),   // fi, soumi  (last)
            locale(.hungarian)  // hu, magyar (first)
        ]
        let result = locales.sorted(
            insertFirst: locale(.swedish)
        )
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["sv", "hu", "fi"])
    }

    func testSortedInLocaleUsesTheLocaleLocalizedName() {
        let locales = [
            locale(.finnish),   // fi, Finnish (first)
            locale(.hungarian)  // hu, Hungarian (last)
        ]
        let result = locales.sorted(in: locale(.english))
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["fi", "hu"])
    }

    func testSortedInLocaleCanPlaceLocaleFirst() {
        let locales = [
            locale(.finnish),   // fi, Finnish (first)
            locale(.hungarian)  // hu, Hungarian (last)
        ]
        let result = locales.sorted(
            in: locale(.english),
            insertFirst: locale(.swedish)
        )
        let ids = result.map { $0.identifier }
        XCTAssertEqual(ids, ["sv", "fi", "hu"])
    }
}
