//
//  LocaleNameProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
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
        XCTAssertEqual(localizedName(of: "sv"), "svenska")
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
}
