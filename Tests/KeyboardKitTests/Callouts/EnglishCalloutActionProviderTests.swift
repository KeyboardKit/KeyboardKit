//
//  EnglishCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class EnglishCalloutActionProviderTests: XCTestCase {

    var provider: EnglishCalloutActionProvider!

    override func setUp() {
        provider = try? EnglishCalloutActionProvider()
    }

    func testLocaleIsCorrect() {
        XCTAssertEqual(provider.localeKey, "en")
    }

    func testCalloutActionsAreDefinedForSomeActions() {
        let action = KeyboardAction.character("a")
        let actions = provider.calloutActions(for: action)
        let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
        XCTAssertEqual(actions, expected)
    }

    func testCalloutActionsAreEmptyForSomeActions() {
        let action = KeyboardAction.character("å")
        let actions = provider.calloutActions(for: action)
        XCTAssertEqual(actions, [])
    }
}
