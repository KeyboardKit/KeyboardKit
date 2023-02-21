//
//  Locale+LocalizedTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_LocalizedTests: XCTestCase {

    func localizedName(of localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        return locale.localizedName
    }

    func testLocalizedNameIsValid() {
        XCTAssertEqual(localizedName(of: "en"), "English")
        XCTAssertEqual(localizedName(of: "en-GB"), "English (United Kingdom)")
        XCTAssertEqual(localizedName(of: "en-US"), "English (United States)")
        XCTAssertEqual(localizedName(of: "sv"), "Svenska")
    }


    func swedishName(of localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedName(of: locale)
    }

    func testLocalizedNameOfLocaleIsValid() {
        XCTAssertEqual(swedishName(of: "en"), "Engelska")
        XCTAssertEqual(swedishName(of: "en-GB"), "Engelska (Storbritannien)")
        XCTAssertEqual(swedishName(of: "en-US"), "Engelska (Usa)")
        XCTAssertEqual(swedishName(of: "sv-SE"), "Svenska (Sverige)")
    }


    func nameOfSwedish(in localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedName(in: locale)
    }

    func testLocalizedNameInLocaleIsValid() {
        XCTAssertEqual(nameOfSwedish(in: "en"), "Swedish (Sweden)")
        XCTAssertEqual(nameOfSwedish(in: "fi"), "Ruotsi (Ruotsi)")
        XCTAssertEqual(nameOfSwedish(in: "no"), "Svensk (Sverige)")
        XCTAssertEqual(nameOfSwedish(in: "sv"), "Svenska (Sverige)")
    }


    func localizedLanguageName(of localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        return locale.localizedLanguageName
    }

    func testLocalizedLanguageNameIsValid() {
        XCTAssertEqual(localizedLanguageName(of: "en"), "English")
        XCTAssertEqual(localizedLanguageName(of: "en-GB"), "English")
        XCTAssertEqual(localizedLanguageName(of: "en-US"), "English")
        XCTAssertEqual(localizedLanguageName(of: "sv"), "Svenska")
    }


    func swedishName(ofLanguage localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedLanguageName(of: locale)
    }

    func testLocalizedLanguageNameOfLocaleIsValid() {
        XCTAssertEqual(swedishName(ofLanguage: "en"), "Engelska")
        XCTAssertEqual(swedishName(ofLanguage: "en-GB"), "Engelska")
        XCTAssertEqual(swedishName(ofLanguage: "en-US"), "Engelska")
        XCTAssertEqual(swedishName(ofLanguage: "sv-SE"), "Svenska")
    }


    func nameOfSwedishLanguage(in localeId: String) -> String? {
        let locale = Locale(identifier: localeId)
        let swedish = Locale(identifier: "sv-SE")
        return swedish.localizedLanguageName(in: locale)
    }

    func testLocalizedLanguageNameInLocaleIsValid() {
        XCTAssertEqual(nameOfSwedishLanguage(in: "en"), "Swedish")
        XCTAssertEqual(nameOfSwedishLanguage(in: "fi"), "Ruotsi")
        XCTAssertEqual(nameOfSwedishLanguage(in: "no"), "Svensk")
        XCTAssertEqual(nameOfSwedishLanguage(in: "sv"), "Svenska")
    }
}
