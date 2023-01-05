//
//  StandardCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class StandardCalloutActionProviderTests: XCTestCase {

    var provider: StandardCalloutActionProvider!
    var context: KeyboardContext!

    override func setUp() {
        context = KeyboardContext()
        provider = StandardCalloutActionProvider(
            keyboardContext: context
        )
    }

    func testLocalizedProvidersHaveStandardProviders() {
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 1)
        XCTAssertTrue(providers[KeyboardLocale.english.id] is EnglishCalloutActionProvider)
    }

    func testLocalizedProvidersAcceptCustomProviders() {
        provider = StandardCalloutActionProvider(
            keyboardContext: context,
            providers: [StandardCalloutActionProvider.standardProvider])
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 1)
        XCTAssertTrue(providers[KeyboardLocale.english.id] is EnglishCalloutActionProvider)
    }


    func testCalloutActionsSupportEnglish() {
        context.locale = Locale(identifier: KeyboardLocale.english.id)
        let action = KeyboardAction.character("a")
        let actions = provider.calloutActions(for: action)
        let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }

    func testCalloutActionsHaveFallbackForSpecificLocale() {
        context.locale = Locale(identifier: "en-US")
        let action = KeyboardAction.character("a")
        let actions = provider.calloutActions(for: action)
        let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }

    func testCalloutActionsHaveFallbackForNonSupportedLocale() {
        context.locale = Locale(identifier: KeyboardLocale.german.id)
        let action = KeyboardAction.character("a")
        let actions = provider.calloutActions(for: action)
        let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }
}
