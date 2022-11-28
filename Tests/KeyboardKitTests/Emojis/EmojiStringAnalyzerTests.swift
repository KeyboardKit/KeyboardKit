//
//  EmojiStringAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class EmojiStringAnalyzerTests: XCTestCase {

    func testContainsEmojiReturnsTrueIfStringContainsEmojis() {
        XCTAssertFalse("abc".containsEmoji)
        XCTAssertTrue("a👍c".containsEmoji)
        XCTAssertTrue("😀abc😀".containsEmoji)
    }

    func testContainsOnlyEmojisReturnsTrueIfStringOnlyContainsEmojis() {
        XCTAssertFalse("abc".containsOnlyEmojis)
        XCTAssertFalse("a👍c".containsOnlyEmojis)
        XCTAssertTrue("👍".containsOnlyEmojis)
    }

    func testEmojisReturnsAllEmojiCharactersInString() {
        XCTAssertEqual("abc".emojis, [])
        XCTAssertEqual("a👍c".emojis, ["👍"])
        XCTAssertEqual("smile🙂👍ok".emojis, ["🙂", "👍"])
    }

    func testEmojiScalarsReturnsAllEmojiScalarsInString() {
        XCTAssertEqual("abc".emojiScalars, [])
        XCTAssertEqual("a👍c".emojiScalars, ["👍"])
        XCTAssertEqual("smile🙂👍ok".emojiScalars, ["🙂", "👍"])
    }

    func testEmojiStringReturnsAllEmojisInString() {
        XCTAssertEqual("abc".emojiString, "")
        XCTAssertEqual("a👍c".emojiString, "👍")
        XCTAssertEqual("smile🙂👍ok".emojiString, "🙂👍")
    }

    func testIsSingleEmojiReturnTrueForSingleEmojiString() {
        XCTAssertFalse("abc".isSingleEmoji)
        XCTAssertTrue("👍".isSingleEmoji)
        XCTAssertFalse("smile🙂👍ok".isSingleEmoji)
    }
}
