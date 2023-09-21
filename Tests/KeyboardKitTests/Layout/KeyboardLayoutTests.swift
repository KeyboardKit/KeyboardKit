//
//  KeyboardLayoutTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

class KeyboardLayoutTests: XCTestCase {

    func item(_ width: KeyboardLayout.ItemWidth) -> KeyboardLayout.Item {
        let size = KeyboardLayout.ItemSize(width: width, height: 0)
        let item = KeyboardLayout.Item(action: .none, size: size)
        return item
    }
    
    func testInputWidthReturnsZeroIfNoItemsExist() {
        let layout = KeyboardLayout(itemRows: [])
        XCTAssertEqual(layout.inputWidth(for: 123), 0)
    }

    func testInputWidthReturnsCachedResultIfOneExists() {
        let layout = KeyboardLayout(itemRows: [])
        layout.widthCache[123] = 456
        XCTAssertEqual(layout.inputWidth(for: 123), 456)
    }

    func testInputWidthHasPrecedenceOverAvailableWidth() {
        let layout = KeyboardLayout(itemRows: [[
            item(.available),
            item(.input),
            item(.input),
            item(.available)
        ]])
        let result = layout.inputWidth(for: 200)
        XCTAssertEqual(result, 100)
    }

    func testPercentageWidthHasPrecedenceOverInputWidth() {
        let layout = KeyboardLayout(itemRows: [[
            item(.percentage(0.2)),
            item(.input),
            item(.input),
            item(.percentage(0.2))
        ]])
        let result = layout.inputWidth(for: 200)
        XCTAssertEqual(result, 60)
    }

    func testFixedWidthHasPrecedenceOverInputWidth() {
        let layout = KeyboardLayout(itemRows: [[
            item(.points(50)),
            item(.input),
            item(.input),
            item(.points(50))
        ]])
        let result = layout.inputWidth(for: 200)
        XCTAssertEqual(result, 50)
    }

    func testInputPercentageContributesToInputWidth() {
        let layout = KeyboardLayout(itemRows: [[
            item(.points(50)),
            item(.inputPercentage(0.6)),
            item(.input),
            item(.points(50))
        ]])
        let result = layout.inputWidth(for: 200)
        XCTAssertEqual(result, 62.5)
    }
}
