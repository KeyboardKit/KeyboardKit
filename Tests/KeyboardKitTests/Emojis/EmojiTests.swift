//
//  EmojiTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class EmojiTests: XCTestCase {

    func testEmojiUsesCharAsUniqueIdentifier() {
        let emojis = "🕓😀🐻🍔⚽️🚗💡💱🏳️".chars.map { Emoji($0) }
        emojis.forEach {
            XCTAssertEqual($0.id, $0.char)
        }
    }
}
