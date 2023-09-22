//
//  StandardKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class StandardKeyboardLayoutProviderTests: XCTestCase {
    
    var context: KeyboardContext!
    var provider: StandardKeyboardLayoutProvider!

    override func setUp() {
        context = KeyboardContext()
        provider = StandardKeyboardLayoutProvider(
            baseProvider: InputSetBasedKeyboardLayoutProvider(),
            localizedProviders: [TestKeyboardLayoutProvider()]
        )
    }

    func testUsesLocalizedProviderIfOneMatchesContext() {
        context.locale = .init(identifier: "sv-SE")
        let layout = provider.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertTrue(result is TestKeyboardLayoutProvider)
        XCTAssertEqual(firstItem?.action, .character("a"))
    }
    
    func testUsesBaseProviderIfNoLocalizedMatchesContext() {
        context.locale = .init(identifier: "da-DK")
        let layout = provider.keyboardLayout(for: context)
        let firstItem = layout.itemRows[0].first
        let result = provider.keyboardLayoutProvider(for: context)
        XCTAssertTrue(result is InputSetBasedKeyboardLayoutProvider)
        XCTAssertEqual(firstItem?.action, .character("q"))
    }
}

private class TestKeyboardLayoutProvider: SystemKeyboardLayoutProvider, LocalizedService {
    
    let localeKey = "sv-SE"
    
    init() {
        super.init(
            alphabeticInputSet: .init(rows: [.init(chars: "abcdefghij")]),
            numericInputSet: .standardNumeric(currency: "$"),
            symbolicInputSet: .standardSymbolic(currencies: "€£¥".chars)
        )
    }
}
