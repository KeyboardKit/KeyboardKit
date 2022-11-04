//
//  KeyboardAction+InputCalloutTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_InputCalloutTests: XCTestCase {

    func testInputCalloutTextIsOnlySpecifiedForCharacterActions() {
        let action = KeyboardAction.character("foo")
        let others = KeyboardAction.testActions.filter { !$0.isCharacterAction }
        XCTAssertEqual(action.inputCalloutText, "foo")
        others.forEach {
            XCTAssertNil($0.inputCalloutText)
        }
    }
}
