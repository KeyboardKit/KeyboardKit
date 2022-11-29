//
//  KKL10nTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KKL10nTests: XCTestCase {
    
    func testBundlePathIsValidForAllKeyboardLocales() {
        KeyboardLocale.allCases.forEach {
            let bundle = Bundle.keyboardKit
            let path = bundle.bundlePath(for: $0.locale) ?? ""
            XCTAssertNotNil(path)
            XCTAssertTrue(FileManager.default.fileExists(atPath: path))
        }
    }

    func assertTextResult(for locale: KeyboardLocale, key: KKL10n) {
        XCTAssertFalse(key.text(for: locale).isEmpty)
    }

    func testTextForLocaleIsNotEmptyForAnyLocale() {
        KeyboardLocale.allCases.forEach {
            assertTextResult(for: $0, key: .done)
            assertTextResult(for: $0, key: .go)
            assertTextResult(for: $0, key: .ok)
            assertTextResult(for: $0, key: .return)
            assertTextResult(for: $0, key: .search)
            assertTextResult(for: $0, key: .space)

            assertTextResult(for: $0, key: .keyboardTypeAlphabetic)
            assertTextResult(for: $0, key: .keyboardTypeNumeric)
            assertTextResult(for: $0, key: .keyboardTypeSymbolic)
        }
    }
}
