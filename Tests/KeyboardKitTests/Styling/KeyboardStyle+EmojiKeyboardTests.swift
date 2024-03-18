//
//  KeyboardStyle+EmojiKeyboardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardStyle_EmojiKeyboardTests: XCTestCase {

    func testStandardLargePadLandscape() {
        let config = KeyboardStyle.EmojiKeyboard.standardLargePadLandscape
        XCTAssertEqual(config.rows, 6)
        XCTAssertEqual(config.horizontalItemSpacing, 10)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 10)
        XCTAssertEqual(config.categoryTitlePadding, .init(top: 18, leading: 0, bottom: 0, trailing: 0))
    }

    func testStandardLargePadPortrait() {
        let config = KeyboardStyle.EmojiKeyboard.standardLargePadPortrait
        XCTAssertEqual(config.rows, 5)
        XCTAssertEqual(config.itemSize, 55)
        XCTAssertEqual(config.horizontalItemSpacing, 10)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 7)
        #if os(iOS)
        XCTAssertEqual(config.categoryTitleFont, .system(size: 16).bold())
        #endif
        XCTAssertEqual(config.categoryTitlePadding, .init(top: 14, leading: 0, bottom: 0, trailing: 0))
    }

    func testStandardPadLandscape() {
        let config = KeyboardStyle.EmojiKeyboard.standardPadLandscape
        XCTAssertEqual(config.rows, 5)
        XCTAssertEqual(config.itemSize, 58)
        XCTAssertEqual(config.horizontalItemSpacing, 15)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 7)
    }

    func testStandardPadPortrait() {
        let config = KeyboardStyle.EmojiKeyboard.standardPadPortrait
        XCTAssertEqual(config.rows, 3)
        XCTAssertEqual(config.itemSize, 67)
        XCTAssertEqual(config.horizontalItemSpacing, 15)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 5)
    }

    func testStandardPhoneLandscape() {
        let config = KeyboardStyle.EmojiKeyboard.standardPhoneLandscape
        XCTAssertEqual(config.rows, 3)
    }

    func testStandardPhonePortrait() {
        let config = KeyboardStyle.EmojiKeyboard.standardPhonePortrait
        XCTAssertEqual(config.rows, 5)
    }
}
