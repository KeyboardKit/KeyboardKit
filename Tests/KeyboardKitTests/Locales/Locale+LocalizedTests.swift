//
//  Locale+LocalizedTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_TextTests: XCTestCase {
    
    func testLocalizedNameIsValid() {
        let locale = Locale(identifier: "en-US")
        XCTAssertEqual(locale.localizedName, "English (United States)")
    }

    func testLocalizedLanguageNameIsValid() {
        let locale = Locale(identifier: "en-US")
        XCTAssertEqual(locale.localizedLanguageName, "English")
    }
}
