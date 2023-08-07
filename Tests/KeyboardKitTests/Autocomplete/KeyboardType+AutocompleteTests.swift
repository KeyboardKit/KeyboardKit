//
//  KeyboardType+AutocompleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

#if os(iOS) || os(tvOS)
import UIKit
#endif

class KeyboardType_AutocompleteTests: XCTestCase {

    func prefersAutocompleteResult(for type: Keyboard.KeyboardType) -> Bool {
        type.prefersAutocomplete
    }

    func testKeyboardTypePrefersAutocomplete() {
        XCTAssertTrue(prefersAutocompleteResult(for: .alphabetic(.lowercased)))
        XCTAssertTrue(prefersAutocompleteResult(for: .numeric))
        XCTAssertTrue(prefersAutocompleteResult(for: .symbolic))
        XCTAssertFalse(prefersAutocompleteResult(for: .email))
        XCTAssertFalse(prefersAutocompleteResult(for: .emojis))
        XCTAssertFalse(prefersAutocompleteResult(for: .images))
        XCTAssertTrue(prefersAutocompleteResult(for: .custom(named: "")))
    }


    #if os(iOS) || os(tvOS)
    func prefersAutocompleteResult(for type: UIKeyboardType) -> Bool {
        type.prefersAutocomplete
    }

    func testNativeKeyboardTypePrefersAutocomplete() {
        XCTAssertTrue(prefersAutocompleteResult(for: .default))
        XCTAssertTrue(prefersAutocompleteResult(for: .alphabet))
        XCTAssertFalse(prefersAutocompleteResult(for: .asciiCapableNumberPad))
        XCTAssertTrue(prefersAutocompleteResult(for: .asciiCapable))
        XCTAssertFalse(prefersAutocompleteResult(for: .decimalPad))
        XCTAssertFalse(prefersAutocompleteResult(for: .emailAddress))
        XCTAssertFalse(prefersAutocompleteResult(for: .namePhonePad))
        XCTAssertFalse(prefersAutocompleteResult(for: .numberPad))
        XCTAssertFalse(prefersAutocompleteResult(for: .numbersAndPunctuation))
        XCTAssertFalse(prefersAutocompleteResult(for: .phonePad))
        XCTAssertTrue(prefersAutocompleteResult(for: .twitter))
        XCTAssertFalse(prefersAutocompleteResult(for: .URL))
        XCTAssertFalse(prefersAutocompleteResult(for: .webSearch))
    }
    #endif
}
