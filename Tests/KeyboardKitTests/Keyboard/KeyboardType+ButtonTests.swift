//
//  KeyboardCasing+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class KeyboardType_ButtonTests: XCTestCase {

    func buttonImage(for type: KeyboardType) -> Image? {
        type.standardButtonImage
    }

    func buttonText(for type: KeyboardType) -> String? {
        type.standardButtonText(for: .preview)
    }


    func testSystemKeyboardButtonImageIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonImage(for: .email), .keyboardEmail)
        XCTAssertEqual(buttonImage(for: .emojis), .keyboardEmoji)
        XCTAssertEqual(buttonImage(for: .images), .keyboardImages)

        XCTAssertNil(buttonImage(for: .alphabetic(.lowercased)))
        XCTAssertNil(buttonImage(for: .custom(named: "")))
        XCTAssertNil(buttonImage(for: .numeric))
        XCTAssertNil(buttonImage(for: .symbolic))
    }

    func testSystemKeyboardButtonTextIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonText(for: .alphabetic(.lowercased)), "ABC")
        XCTAssertEqual(buttonText(for: .numeric), "123")
        XCTAssertEqual(buttonText(for: .symbolic), "#+=")

        XCTAssertNil(buttonText(for: .email))
        XCTAssertNil(buttonText(for: .emojis))
        XCTAssertNil(buttonText(for: .custom(named: "")))
        XCTAssertNil(buttonText(for: .images))
    }
}
