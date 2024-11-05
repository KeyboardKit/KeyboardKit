//
//  KeyboardCallout+CalloutStyleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-03.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

import KeyboardKit
import XCTest

class Callouts_CalloutStyleTests: XCTestCase {

    func testStandardCalloutStyleIsValid() {
        let style = KeyboardCallout.CalloutStyle.standard
        XCTAssertEqual(style.actionItemFont, .title3)
        XCTAssertEqual(style.actionItemMaxSize, .init(width: 50, height: 50))
        XCTAssertEqual(style.actionItemPadding, .init(width: 0, height: 6))
        XCTAssertEqual(style.backgroundColor, .keyboardButtonBackground)
        XCTAssertEqual(style.borderColor, .black.opacity(0.5))
        XCTAssertEqual(style.buttonOverlayCornerRadius, nil)
        XCTAssertEqual(style.buttonOverlayInset, .zero)
        XCTAssertEqual(style.cornerRadius, 10)
        XCTAssertEqual(style.curveSize, .init(width: 8, height: 15))
        XCTAssertEqual(style.foregroundColor, .primary)
        XCTAssertEqual(style.inputItemFont, .largeTitle(weight: .light))
        XCTAssertEqual(style.inputItemMinSize, .init(width: 0, height: 55))
        XCTAssertEqual(style.offset, nil)
        XCTAssertEqual(style.selectedBackgroundColor, .blue)
        XCTAssertEqual(style.selectedForegroundColor, .white)
        XCTAssertEqual(style.shadowColor, .black.opacity(0.1))
        XCTAssertEqual(style.shadowRadius, 5)
    }

    func testStyleSpecifiesDeviceSpecificOffset() {
        let style = KeyboardCallout.CalloutStyle.standard
        XCTAssertEqual(style.standardVerticalOffset(for: .phone), 0)
        XCTAssertEqual(style.standardVerticalOffset(for: .pad), 20)
    }
}
