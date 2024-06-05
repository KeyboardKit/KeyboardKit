//
//  KeyboardLayout+StandardProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class KeyboardLayout_StandardProviderTests: XCTestCase {
    
    var context: KeyboardContext!
    var provider: KeyboardLayout.StandardProvider!

    override func setUp() {
        context = .init()
        provider = .init(
            baseProvider: KeyboardLayout.DeviceBasedProvider(),
            localizedProviders: [TestProvider()]
        )
    }
    
    override func tearDown() {
        KeyboardLayout.StandardProvider.localizedProviderResolver = nil
    }

    func testUsesLocalizedProviderIfOneMatchesContext() {
        context.locale = .init(identifier: "sv")
        let layout = provider.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertNotNil(result)
        XCTAssertTrue(result is TestProvider)
        XCTAssertEqual(firstItem?.action, .character("a"))
    }
    
    func testUsesBaseProviderIfNoLocalizedMatchesContext() {
        context.locale = .init(identifier: "da-DK")
        let layout = provider.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertTrue(result is KeyboardLayout.DeviceBasedProvider)
        XCTAssertEqual(firstItem?.action, .character("q"))
    }
    
    func testCanRegisterLocalizedProvider() {
        let locale = KeyboardLocale.albanian
        let new = TestProvider(localeKey: locale.localeIdentifier)
        XCTAssertNil(provider.localizedProviders.value(for: locale.locale))
        provider.registerLocalizedProvider(new)
        XCTAssertIdentical(provider.localizedProviders.value(for: locale.locale), new)
    }
    
    
    func testCanResolveLayoutProviderWithStaticResolver() {
        KeyboardLayout.StandardProvider.localizedProviderResolver = { locale in
            if locale == .albanian { return TestProvider(localeKey: "apa") }
            return nil
        }
        context.setLocale(KeyboardLocale.albanian)
        XCTAssertNil(provider.localizedProviders.value(for: KeyboardLocale.albanian))
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertEqual((result as? TestProvider)?.localeKey, "apa")
        XCTAssertTrue(provider.localizedProviders.value(for: KeyboardLocale.albanian) is TestProvider)
    }
}

private class TestProvider: KeyboardLayout.BaseProvider, LocalizedService {

    init(localeKey: String = "sv") {
        self.localeKey = localeKey
        super.init(
            alphabeticInputSet: .init(rows: [.init(chars: "abcdefghij")]),
            numericInputSet: .numeric(currency: "$"),
            symbolicInputSet: .symbolic(currencies: "€£¥".chars)
        )
    }
    
    var localeKey: String
}
