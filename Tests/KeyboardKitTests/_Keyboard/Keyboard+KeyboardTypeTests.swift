//
//  Keyboard+KeyboardTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class Keyboard_KeyboardTypeTests: XCTestCase {

    func isAlphabetic(_ type: Keyboard.KeyboardType) -> Bool {
        type.isAlphabetic
    }

    func isAlphabeticUppercased(_ type: Keyboard.KeyboardType) -> Bool {
        type.isAlphabeticUppercased
    }

    func isAlphabetic(_ type: Keyboard.KeyboardType, _ keyboardCase: Keyboard.Case) -> Bool {
        type.isAlphabetic(keyboardCase)
    }
    
    
    func buttonImage(for type: Keyboard.KeyboardType) -> Image? {
        type.standardButtonImage
    }

    func buttonText(for type: Keyboard.KeyboardType) -> String? {
        type.standardButtonText(for: .preview)
    }
    

    func testIsAlphabeticIsOnlyTrueForAlphabeticTypes() {
        XCTAssertTrue(isAlphabetic(.alphabetic(.lowercased)))
        XCTAssertTrue(isAlphabetic(.alphabetic(.uppercased)))
        XCTAssertTrue(isAlphabetic(.alphabetic(.capsLocked)))
        XCTAssertFalse(isAlphabetic(.numeric))
        XCTAssertFalse(isAlphabetic(.symbolic))
        XCTAssertFalse(isAlphabetic(.email))
        XCTAssertFalse(isAlphabetic(.emojis))
        XCTAssertFalse(isAlphabetic(.images))
        XCTAssertFalse(isAlphabetic(.images))
        XCTAssertFalse(isAlphabetic(.custom(named: "")))
    }

    func testIsAlphabeticUppercasedIsTrueForUppercaseOrCapslock() {
        XCTAssertFalse(isAlphabeticUppercased(.alphabetic(.lowercased)))
        XCTAssertTrue(isAlphabeticUppercased(.alphabetic(.uppercased)))
        XCTAssertTrue(isAlphabeticUppercased(.alphabetic(.capsLocked)))
    }

    func testIsAlphabeticWithCaseIsTrueForMatchingTypes() {
        XCTAssertFalse(isAlphabetic(.alphabetic(.lowercased), .uppercased))
        XCTAssertTrue(isAlphabetic(.alphabetic(.uppercased), .uppercased))
        XCTAssertTrue(isAlphabetic(.alphabetic(.capsLocked), .capsLocked))
    }


    func testButtonImageIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonImage(for: .email), .keyboardEmail)
        XCTAssertEqual(buttonImage(for: .emojis), .keyboardEmoji)
        XCTAssertEqual(buttonImage(for: .images), .keyboardImages)

        XCTAssertNil(buttonImage(for: .alphabetic(.lowercased)))
        XCTAssertNil(buttonImage(for: .custom(named: "")))
        XCTAssertNil(buttonImage(for: .numeric))
        XCTAssertNil(buttonImage(for: .symbolic))
    }

    func testButtonTextIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonText(for: .alphabetic(.lowercased)), "ABC")
        XCTAssertEqual(buttonText(for: .numeric), "123")
        XCTAssertEqual(buttonText(for: .symbolic), "#+=")

        XCTAssertNil(buttonText(for: .email))
        XCTAssertNil(buttonText(for: .emojis))
        XCTAssertNil(buttonText(for: .custom(named: "")))
        XCTAssertNil(buttonText(for: .images))
    }
}
