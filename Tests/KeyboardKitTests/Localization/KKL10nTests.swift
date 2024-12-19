//
//  KKL10nTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KKL10nTests: XCTestCase {

    let locales = Locale.keyboardKitSupported

    func testBundlePathIsValidForAllSupportedLocales() {
        locales.forEach {
            let bundle = Bundle.keyboardKit
            let path = bundle.bundlePath(for: $0) ?? ""
            let exists = FileManager.default.fileExists(atPath: path)
            XCTAssertNotNil(path)
            XCTAssertTrue(exists, $0.identifier)
        }
    }

    func testTextForContextReturnsCorrectText() {
        let key = KKL10n.done
        let context = KeyboardContext()
        context.locale = .english
        XCTAssertEqual(key.text(for: context), "done")
        context.locale = .swedish
        XCTAssertEqual(key.text(for: context), "klar")
    }

    func testTextForLocaleReturnsCorrectText() {
        let key = KKL10n.done
        XCTAssertEqual(key.text(for: .english), "done")
        XCTAssertEqual(key.text(for: .swedish), "klar")
    }
    
    func assertTextResult(for locale: Locale, key: KKL10n) {
        XCTAssertFalse(key.text(for: locale).isEmpty)
    }

    func testTextForLocaleIsNotEmptyForAnyLocale() {
        locales.forEach {
            assertTextResult(for: $0, key: .done)
            assertTextResult(for: $0, key: .go)
            assertTextResult(for: $0, key: .ok)
            assertTextResult(for: $0, key: .return)
            assertTextResult(for: $0, key: .search)
            assertTextResult(for: $0, key: .space)

            assertTextResult(for: $0, key: .switcherAlphabetic)
            assertTextResult(for: $0, key: .switcherNumeric)
            assertTextResult(for: $0, key: .switcherSymbolic)
        }
    }

    func testTextForLocaleCorrectlyResolvesLocaleBundle() {
        XCTAssertEqual(KKL10n.done.text(for: .english), "done")
        XCTAssertEqual(KKL10n.done.text(for: .swedish), "klar")
    }

    func testTextForCustomKeyResolvesLocaleBundle() {
        XCTAssertEqual(KKL10n.text(forKey: "done", locale: .english), "done")
        XCTAssertEqual(KKL10n.text(forKey: "done", locale: .swedish), "klar")
    }

    func testTextForCustomKeyReturnsKeyIfLocalizationIsMissing() {
        XCTAssertEqual(KKL10n.text(forKey: "abra.kadabra", locale: .english), "abra.kadabra")
    }
}
