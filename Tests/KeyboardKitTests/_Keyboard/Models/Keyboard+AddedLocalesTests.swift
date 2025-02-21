//
//  Keyboard+AddedLocalesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class Keyboard_AddedLocalesTests: XCTestCase {
    
    func testAddedLocaleCanResolveLocale() {
        let locale = Keyboard.AddedLocale(.english)
        XCTAssertEqual(locale.locale, .english)
        XCTAssertEqual(locale.localeIdentifier, "en")
        XCTAssertNotEqual(locale.locale, .swedish)
    }
    
    func testAddedLocaleCanResolveLayoutType() {
        let locale1 = Keyboard.AddedLocale(.english)
        XCTAssertNotEqual(locale1.layoutType, .qwerty)
        let locale2 = Keyboard.AddedLocale(.english, layoutType: .qwerty)
        XCTAssertEqual(locale2.layoutType, .qwerty)
        XCTAssertEqual(locale2.layoutTypeIdentifier, "qwerty")
    }
    
    func testAddedLocaleCanResolveAllSupported() {
        let all = Keyboard.AddedLocale.keyboardKitSupported
        let allLocales = all.compactMap { $0.locale }
        let locales = Locale.keyboardKitSupported
        XCTAssertEqual(allLocales, locales)
    }
}
