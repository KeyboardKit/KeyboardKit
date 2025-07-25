//
//  Locale+NameTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_NameTests: XCTestCase {

    let locales = Locale.keyboardKitSupported

    func testLocalizedNameIsValidForAllSupportedLocales() {
        let expected: [Locale: String] = [
            .albanian: "shqip",
            .arabic: "العربية",
            .armenian: "հայերեն",
            .azerbaijani: "azərbaycan",
            .belarusian: "беларуская",
            .bengali: "বাংলা",
            .bulgarian: "български",
            .dutch_belgium: "Nederlands (België)",
            .catalan: "català",
            .cherokee: "ᏣᎳᎩ",
            .chuvash: "чӑваш",
            .croatian: "hrvatski",
            .czech: "čeština",
            .danish: "dansk",
            .dutch: "Nederlands",
            .english: "English",
            .english_australia: "English (Australia)",
            .english_canada: "English (Canada)",
            .english_gb: "English (United Kingdom)",
            .english_us: "English (United States)",
            .estonian: "eesti",
            .faroese: "føroyskt",
            .filipino: "Filipino",
            .finnish: "suomi",
            .french: "français",
            .french_belgium: "français (Belgique)",
            .french_canada: "français (Canada)",
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
            .inari_sami: "anarâškielâ",
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
            .northern_sami: "davvisámegiella",
            .norwegian: "norsk bokmål",
            .norwegian_nynorsk: "norsk nynorsk",
            .persian: "فارسی",
            .polish: "polski",
            .portuguese: "português (Portugal)",
            .portuguese_brazil: "português (Brasil)",
            .romanian: "română",
            .russian: "русский",
            .serbian: "српски",
            .serbian_latin: "srpski (latinica)",
            .shughni_tajik: "Shughni Tajik",
            .slovenian: "slovenščina",
            .slovak: "slovenčina",
            .spanish: "español",
            .spanish_latinAmerica: "español (Latinoamérica)",
            .spanish_mexico: "español (México)",
            .swahili: "Kiswahili",
            .swedish: "svenska",
            .turkish: "Türkçe",
            .ukrainian: "українська",
            .uzbek: "o‘zbek",
            .vietnamese: "Tiếng Việt",
            .welsh: "Cymraeg"
        ]

        XCTAssertEqual(expected.keys.count, locales.count)
        expected.keys.forEach {
            XCTAssertEqual(expected[$0], $0.localizedName, $0.keyboardKitName)
        }
    }

    func localizedName(of: Locale, in locale: Locale) -> String? {
        of.localizedName(in: locale)
    }

    func testLocalizedNameInOtherLocaleIsValid() {
        XCTAssertEqual(localizedName(of: .english, in: .english), "English")
        XCTAssertEqual(localizedName(of: .english, in: .swedish), "engelska")
        XCTAssertEqual(localizedName(of: .swedish, in: .english), "Swedish")
        XCTAssertEqual(localizedName(of: .swedish, in: .swedish), "svenska")
        XCTAssertEqual(localizedName(of: .vietnamese, in: .english), "Vietnamese")
        XCTAssertEqual(localizedName(of: .vietnamese, in: .swedish), "vietnamesiska")
    }

    func testKeyboardKitNameIsValidForAllSupportedLocales() {
        let expected: [Locale: String] = [
            .albanian: "albanian",
            .arabic: "arabic",
            .armenian: "armenian",
            .azerbaijani: "azerbaijani",
            .belarusian: "belarusian",
            .bengali: "bengali",
            .bulgarian: "bulgarian",
            .catalan: "catalan",
            .cherokee: "cherokee",
            .chuvash: "chuvash",
            .croatian: "croatian",
            .czech: "czech",
            .danish: "danish",
            .dutch: "dutch",
            .dutch_belgium: "dutch_belgium",
            .english: "english",
            .english_australia: "english_australia",
            .english_canada: "english_canada",
            .english_gb: "english_gb",
            .english_us: "english_us",
            .estonian: "estonian",
            .faroese: "faroese",
            .filipino: "filipino",
            .finnish: "finnish",
            .french: "french",
            .french_belgium: "french_belgium",
            .french_canada: "french_canada",
            .french_switzerland: "french_switzerland",
            .georgian: "georgian",
            .german: "german",
            .german_austria: "german_austria",
            .german_switzerland: "german_switzerland",
            .greek: "greek",
            .hawaiian: "hawaiian",
            .hebrew: "hebrew",
            .hungarian: "hungarian",
            .icelandic: "icelandic",
            .inari_sami: "inari_sami",
            .indonesian: "indonesian",
            .irish: "irish",
            .italian: "italian",
            .kazakh: "kazakh",
            .kurdish_sorani: "kurdish_sorani",
            .kurdish_sorani_arabic: "kurdish_sorani_arabic",
            .kurdish_sorani_pc: "kurdish_sorani_pc",
            .latvian: "latvian",
            .lithuanian: "lithuanian",
            .macedonian: "macedonian",
            .malay: "malay",
            .maltese: "maltese",
            .mongolian: "mongolian",
            .northern_sami: "northern_sami",
            .norwegian: "norwegian",
            .norwegian_nynorsk: "norwegian_nynorsk",
            .persian: "persian",
            .polish: "polish",
            .portuguese: "portuguese",
            .portuguese_brazil: "portuguese_brazil",
            .romanian: "romanian",
            .russian: "russian",
            .shughni_tajik: "shugni_tajik",
            .serbian: "serbian",
            .serbian_latin: "serbian_latin",
            .slovenian: "slovenian",
            .slovak: "slovak",
            .spanish: "spanish",
            .spanish_latinAmerica: "spanish_latinAmerica",
            .spanish_mexico: "spanish_mexico",
            .swahili: "swahili",
            .swedish: "swedish",
            .turkish: "turkish",
            .ukrainian: "ukrainian",
            .uzbek: "uzbek",
            .vietnamese: "vietnamese",
            .welsh: "welsh"
        ]

        XCTAssertEqual(expected.keys.count, locales.count)
        expected.keys.forEach {
            XCTAssertEqual(expected[$0], $0.keyboardKitName)
        }
    }

    func testCanPrintNamesInCommaList() throws {
        print("")
        print("************************")
        print("*** Locale Name List ***")
        print("************************")
        print("")
        let string = locales
            .compactMap { ($0.printName) + " (\($0.identifier))"}
            .joined(separator: ", ")
        print(string)
        print("")
    }

    func testCanPrintNamesInHtmlList() throws {
        print("")
        print("************************")
        print("*** Locale Name List ***")
        print("************************")
        print("")
        locales.forEach { locale in
            print("\(locale.printName) <br />")
        }
        print("")
    }

    func testCanPrintNamesInHtmlBulletList() throws {
        print("")
        print("************************")
        print("*** Locale Name List ***")
        print("************************")
        print("")
        locales.forEach { locale in
            print("<li>\(locale.printName)</li>")
        }
        print("")
    }
}

private extension Locale {

    var printName: String {
        localizedName(in: .english) ?? ""
    }
}
