//
//  Callouts+StandardActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Callouts_StandardActionProviderTests: XCTestCase {
    
    var provider: Callouts.StandardActionProvider!
    var context: KeyboardContext!
    
    override func setUp() {
        context = KeyboardContext()
        provider = .init(keyboardContext: context)
    }
    
    func testLocalizedProvidersHaveNoDefaultProviders() {
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 0)
    }
    
    func testLocalizedProvidersAcceptCustomProviders() {
        provider = .init(
            keyboardContext: context,
            localizedProviders: [
                TestProvider(localeKey: "en"),
                TestProvider(localeKey: "sv")
            ]
        )
        let providers = provider.localizedProviders.dictionary
        XCTAssertEqual(providers.keys.count, 2)
        XCTAssertTrue(providers["en"] is TestProvider)
        XCTAssertTrue(providers["sv"] is TestProvider)
    }
    
    
    func testCalloutActionsMapsContextLocaleToProvider() {
        context.locale = Locale(identifier: KeyboardLocale.english.id)
        provider = .init(
            keyboardContext: context,
            localizedProviders: [TestProvider(localeKey: "en")]
        )
        let action = KeyboardAction.character("a")
        let actions = provider.calloutActions(for: action)
        let expected = "en".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }
    
    func testCalloutActionsReturnsEmptyResultForMissingLocale() {
        context.locale = Locale(identifier: KeyboardLocale.swedish.id)
        provider = .init(
            keyboardContext: context,
            localizedProviders: [TestProvider(localeKey: "en")]
        )
        let nonEmptyActions = provider.calloutActions(for: .character("a"))
        let emptyActions = provider.calloutActions(for: .character("k"))
        XCTAssertNotEqual(nonEmptyActions, [])
        XCTAssertEqual(emptyActions, [])
    }
    
    func testCanRegisterLocalizedProvider() {
        let locale = KeyboardLocale.albanian
        let new = TestProvider(localeKey: locale.localeIdentifier)
        XCTAssertNil(provider.localizedProviders.value(for: locale.locale))
        provider.registerLocalizedProvider(new)
        XCTAssertIdentical(provider.localizedProviders.value(for: locale.locale), new)
    }
}

private class TestProvider: CalloutActionProvider, LocalizedService {
    
    init(localeKey: String) {
        self.localeKey = localeKey
    }
    
    let localeKey: String
    
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            guard char == "a" else { return [] }
            return localeKey.chars.map { .character($0) }
        default: return []
        }
    }
}
