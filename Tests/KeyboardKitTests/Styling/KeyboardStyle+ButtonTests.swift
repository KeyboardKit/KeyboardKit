//
//  KeyboardStyle+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-19.
//  Copyright ©  Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KeyboardStyle_ButtonTests: XCTestCase {

    func testOverrideAppliesAllAvailableProperties() {
        let style1 = Keyboard.ButtonStyle.init(backgroundColor: .purple)
        let style2 = Keyboard.ButtonStyle.init(backgroundColor: .pink)
        let result = style1.extended(with: style2)
        XCTAssertEqual(result.backgroundColor, style2.backgroundColor)
        XCTAssertEqual(result.foregroundColor, style2.foregroundColor)
        XCTAssertEqual(result.keyboardFont, style2.keyboardFont)
        XCTAssertEqual(result.cornerRadius, style2.cornerRadius)
        XCTAssertEqual(result.border, style2.border)
        XCTAssertEqual(result.shadow, style2.shadow)
    }

    func testOverrideIgnoresAllUndefinedProperties() {
        let style1 = Keyboard.ButtonStyle.init(backgroundColor: .purple)
        var style2 = Keyboard.ButtonStyle.init(backgroundColor: .gray)
        style2.cornerRadius = nil
        let result = style1.extended(with: style2)
        XCTAssertEqual(result.backgroundColor, style2.backgroundColor)
        XCTAssertEqual(result.foregroundColor, style2.foregroundColor)
        XCTAssertEqual(result.keyboardFont, style2.keyboardFont)
        XCTAssertEqual(result.cornerRadius, style1.cornerRadius)
        XCTAssertEqual(result.border, style2.border)
        XCTAssertEqual(result.shadow, style2.shadow)
    }
}
