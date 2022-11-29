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

    func fontSize(for type: KeyboardType) -> CGFloat {
        type.standardButtonFontSize(for: KeyboardContext.preview)
    }

    func buttonImage(for type: KeyboardType) -> Image? {
        type.standardButtonImage
    }

    func buttonText(for type: KeyboardType) -> String? {
        type.standardButtonText(for: .preview)
    }


    func testSystemKeyboardButtonFontSizeIsDefinedForAllTypes() {
        XCTAssertEqual(fontSize(for: .alphabetic(.lowercased)), 15)
        XCTAssertEqual(fontSize(for: .numeric), 16)
        XCTAssertEqual(fontSize(for: .symbolic), 14)

        XCTAssertEqual(fontSize(for: .email), 14)
        XCTAssertEqual(fontSize(for: .emojis), 14)
        XCTAssertEqual(fontSize(for: .custom(named: "")), 14)
        XCTAssertEqual(fontSize(for: .images), 14)
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
