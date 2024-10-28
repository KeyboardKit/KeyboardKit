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

    func buttonImage(for type: Keyboard.KeyboardType) -> Image? {
        type.standardButtonImage
    }

    func buttonText(for type: Keyboard.KeyboardType) -> String? {
        type.standardButtonText(for: .preview)
    }

    func testButtonImageIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonImage(for: .email), .keyboardEmail)
        XCTAssertEqual(buttonImage(for: .emojis), .keyboardEmoji)
        XCTAssertEqual(buttonImage(for: .images), .keyboardImages)

        XCTAssertNil(buttonImage(for: .alphabetic))
        XCTAssertNil(buttonImage(for: .custom(named: "")))
        XCTAssertNil(buttonImage(for: .numeric))
        XCTAssertNil(buttonImage(for: .symbolic))
    }

    func testButtonTextIsDefinedForSomeTypes() {
        XCTAssertEqual(buttonText(for: .alphabetic), "ABC")
        XCTAssertEqual(buttonText(for: .numeric), "123")
        XCTAssertEqual(buttonText(for: .symbolic), "#+=")

        XCTAssertNil(buttonText(for: .email))
        XCTAssertNil(buttonText(for: .emojis))
        XCTAssertNil(buttonText(for: .custom(named: "")))
        XCTAssertNil(buttonText(for: .images))
    }
}
