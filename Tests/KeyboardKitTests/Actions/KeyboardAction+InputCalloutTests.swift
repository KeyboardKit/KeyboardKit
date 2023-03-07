//
//  KeyboardAction+InputCalloutTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_InputCalloutTests: XCTestCase {

    func testInputCalloutTextIsOnlySpecifiedForCharacterActions() {
        let char = KeyboardAction.character("foo")
        let emoji = KeyboardAction.emoji(Emoji("😀"))
        let others = KeyboardAction.testActions.filter { !$0.isCharacterAction && !$0.isEmojiAction }
        XCTAssertEqual(char.inputCalloutText, "foo")
        XCTAssertEqual(emoji.inputCalloutText, "😀")
        others.forEach {
            XCTAssertNil($0.inputCalloutText)
        }
    }
}
