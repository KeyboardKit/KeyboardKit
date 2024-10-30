//
//  KeyboardType+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

#if os(iOS) || os(tvOS)
import UIKit
#endif

class KeyboardType_AutocompleteTests: XCTestCase {

    func testKeyboardTypePrefersAutocomplete() {
        let types = Keyboard.KeyboardType.allCases
        let result = Dictionary(uniqueKeysWithValues: types.map { ($0, $0.prefersAutocomplete) })
        XCTAssertEqual(result, [
            .alphabetic: true,
            .email: false,
            .emojis: false,
            .emojiSearch: false,
            .images: false,
            .numberPad: true,
            .numeric: true,
            .symbolic: true,
            .url: false
        ])
    }


    #if os(iOS) || os(tvOS) || os(visionOS)
    func testNativeKeyboardTypePrefersAutocomplete() {
        func result(for type: UIKeyboardType) -> Bool {
            type.prefersAutocomplete
        }
        XCTAssertTrue(result(for: .default))
        XCTAssertTrue(result(for: .alphabet))
        XCTAssertFalse(result(for: .asciiCapableNumberPad))
        XCTAssertTrue(result(for: .asciiCapable))
        XCTAssertFalse(result(for: .decimalPad))
        XCTAssertFalse(result(for: .emailAddress))
        XCTAssertFalse(result(for: .namePhonePad))
        XCTAssertFalse(result(for: .numberPad))
        XCTAssertFalse(result(for: .numbersAndPunctuation))
        XCTAssertFalse(result(for: .phonePad))
        XCTAssertTrue(result(for: .twitter))
        XCTAssertFalse(result(for: .URL))
        XCTAssertFalse(result(for: .webSearch))
    }
    #endif
}
