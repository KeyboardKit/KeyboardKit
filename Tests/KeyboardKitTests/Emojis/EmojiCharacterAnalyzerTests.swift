//
//  EmojiCharacterAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class EmojiCharacterAnalyzerTests: XCTestCase {

    func testIsEmojiReturnsTrueForAllEmojis() {
        let allEmojis = EmojiCategory.all.flatMap { $0.emojis }
        allEmojis.forEach {
            XCTAssertTrue($0.char.char.isEmoji)
        }
    }

    func testIsCombinedEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertFalse("😀".char.isCombinedEmoji)
        XCTAssertTrue("☺️".char.isCombinedEmoji)
    }

    func testIsSimpleEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue("😀".char.isSimpleEmoji)
        XCTAssertFalse("⌚️".char.isSimpleEmoji)
    }
}

private extension String {

    var char: Character { Array(self)[0] }
}
