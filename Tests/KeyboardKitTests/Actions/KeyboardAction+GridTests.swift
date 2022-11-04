//
//  KeyboardAction+GridTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_GridTests: XCTestCase {

    func testEveningForSizeGridDoesntAddActionsIfNotNeeded() {
        let array: [KeyboardAction] = [
            .backspace, .backspace, .backspace, .backspace,
            .backspace, .backspace, .backspace, .backspace
        ]
        let evened = array.evened(for: 4)
        XCTAssertEqual(evened.count, array.count)
    }

    func testEveningForSizeGridAppendsNonActionsIfNeeded() {
        let array: [KeyboardAction] = [
            .backspace, .backspace, .backspace, .backspace,
            .backspace, .backspace
        ]
        let evened = array.evened(for: 4)
        XCTAssertEqual(evened.count, 8)
        XCTAssertEqual(evened[6], KeyboardAction.none)
        XCTAssertEqual(evened[7], KeyboardAction.none)
    }
}
