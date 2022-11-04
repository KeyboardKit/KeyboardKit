//
//  KeyboardAction+RowItemTest.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_RowItemTests: XCTestCase {

    func testRowIdUsesItselfAsId() {
        KeyboardAction.testActions.forEach {
            XCTAssertEqual($0.rowId, $0)
        }
    }
}
