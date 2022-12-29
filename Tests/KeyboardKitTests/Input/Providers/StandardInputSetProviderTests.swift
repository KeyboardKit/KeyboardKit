//
//  StandardInputSetProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class StandardInputSetProviderTests: XCTestCase {

    var provider: StandardInputSetProvider!
    var context: KeyboardContext!
    var english: InputSetProvider!

    override func setUp() {
        context = KeyboardContext()
        provider = StandardInputSetProvider(keyboardContext: context)
        english = EnglishInputSetProvider()
    }

    func testLocalizedProvidersHaveStandardLocaleSpecificProvider() {
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 1)
        XCTAssertTrue(providers[KeyboardLocale.english.id] is EnglishInputSetProvider)
    }

    func testLocalizedProvidersAcceptCustomProviders() {
        provider = StandardInputSetProvider(
            keyboardContext: context,
            localizedProviders: [EnglishInputSetProvider()])
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 1)
        XCTAssertTrue(providers[KeyboardLocale.english.id] is EnglishInputSetProvider)
    }


    func testInputSetsSupportEnglish() {
        context.locale = Locale(identifier: KeyboardLocale.english.id)
        XCTAssertEqual(provider.alphabeticInputSet, english.alphabeticInputSet)
        XCTAssertEqual(provider.numericInputSet, english.numericInputSet)
        XCTAssertEqual(provider.symbolicInputSet, english.symbolicInputSet)
    }

    func testInputSetsHasFallbackToSpecificLocale() {
        context.locale = Locale(identifier: "en-US")
        XCTAssertEqual(provider.alphabeticInputSet, english.alphabeticInputSet)
        XCTAssertEqual(provider.numericInputSet, english.numericInputSet)
        XCTAssertEqual(provider.symbolicInputSet, english.symbolicInputSet)
    }

    func testInputSetsHasFallbackSupportForNonSupportedLocale() {
        context.locale = Locale(identifier: "es")
        XCTAssertEqual(provider.alphabeticInputSet, english.alphabeticInputSet)
        XCTAssertEqual(provider.numericInputSet, english.numericInputSet)
        XCTAssertEqual(provider.symbolicInputSet, english.symbolicInputSet)
    }
}
