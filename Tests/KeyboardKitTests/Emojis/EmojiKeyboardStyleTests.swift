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

    func testStandardConfigurations() {

        func validate(
            _ config: EmojiKeyboardStyle,
            _ itemSize: Double,
            _ rows: Int,
            _ horizontalSpacing: Double,
            _ verticalSpacing: CGFloat
        ) {
            XCTAssertEqual(config.itemSize, itemSize)
            XCTAssertEqual(config.rows, rows)
            XCTAssertEqual(config.horizontalItemSpacing, horizontalSpacing)
            XCTAssertEqual(config.verticalItemSpacing, verticalSpacing)
        }

        validate(.standardLargePadLandscape, 60, 6, 15, 10)
        validate(.standardLargePadPortrait, 60, 5, 10, 7)
        validate(.standardPadLandscape, 60, 5, 15, 10)
        validate(.standardPadPortrait, 60, 3, 15, 10)
        validate(.standardPhoneLandscape, 40, 3, 10, 6)
        validate(.standardPhonePortrait, 40, 5, 10, 6)
    }
}
