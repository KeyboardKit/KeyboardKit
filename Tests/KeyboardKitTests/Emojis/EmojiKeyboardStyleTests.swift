//
//  EmojiKeyboardStyleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class EmojiKeyboardStyleTests: XCTestCase {

    func testStandardLargePadLandscape() {
        let config = EmojiKeyboardStyle.standardLargePadLandscape
        XCTAssertEqual(config.rows, 6)
        XCTAssertEqual(config.horizontalItemSpacing, 10)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 10)
        XCTAssertEqual(config.categoryTitlePadding, .init(top: 18, leading: 0, bottom: 0, trailing: 0))
    }

    func testStandardLargePadPortrait() {
        let config = EmojiKeyboardStyle.standardLargePadPortrait
        XCTAssertEqual(config.rows, 5)
        XCTAssertEqual(config.itemSize, 55)
        XCTAssertEqual(config.horizontalItemSpacing, 10)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 7)
        XCTAssertEqual(config.categoryTitleFont, .system(size: 16).bold())
        XCTAssertEqual(config.categoryTitlePadding, .init(top: 14, leading: 0, bottom: 0, trailing: 0))
    }

    func testStandardPadLandscape() {
        let config = EmojiKeyboardStyle.standardPadLandscape
        XCTAssertEqual(config.rows, 5)
        XCTAssertEqual(config.itemSize, 58)
        XCTAssertEqual(config.horizontalItemSpacing, 15)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 7)
    }

    func testStandardPadPortrait() {
        let config = EmojiKeyboardStyle.standardPadPortrait
        XCTAssertEqual(config.rows, 3)
        XCTAssertEqual(config.itemSize, 67)
        XCTAssertEqual(config.horizontalItemSpacing, 15)
        XCTAssertEqual(config.verticalCategoryStackSpacing, 5)
    }

    func testStandardPhoneLandscape() {
        let config = EmojiKeyboardStyle.standardPhoneLandscape
        XCTAssertEqual(config.rows, 3)
    }

    func testStandardPhonePortrait() {
        let config = EmojiKeyboardStyle.standardPhonePortrait
        XCTAssertEqual(config.rows, 5)
    }
}
