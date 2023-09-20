//
//  Emoji+CharacterTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Emoji_CharacterTests: XCTestCase {

    let combined = "☺️".char
    let nonCombined = "😀".char
    let simple = "😀".char
    let nonSimple = "⌚️".char

    func testIsCombinedEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(combined.isCombinedEmoji)
        XCTAssertFalse(nonCombined.isCombinedEmoji)
    }

    func testIsSimpleEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(simple.isSimpleEmoji)
        XCTAssertFalse(nonSimple.isSimpleEmoji)
    }
}

private extension String {

    var char: Character { Array(self)[0] }
}
