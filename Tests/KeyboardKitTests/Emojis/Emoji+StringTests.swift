//
//  Emoji+StringTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Emoji_StringTests: XCTestCase {

    let noEmoji = "abc"
    let emoji = "👍"
    let emojis = "🙂👍"
    let centerEmoji = "a👍c"
    let inlineEmojis = "foo🙂bar👍bar"

    func testContainsEmojiReturnsTrueIfStringContainsEmojis() {
        XCTAssertFalse(noEmoji.containsEmoji)
        XCTAssertTrue(emoji.containsEmoji)
        XCTAssertTrue(emojis.containsEmoji)
        XCTAssertTrue(centerEmoji.containsEmoji)
        XCTAssertTrue(inlineEmojis.containsEmoji)
    }

    func testContainsOnlyEmojisReturnsTrueIfStringOnlyContainsEmojis() {
        XCTAssertFalse(noEmoji.containsOnlyEmojis)
        XCTAssertTrue(emoji.containsOnlyEmojis)
        XCTAssertTrue(emojis.containsOnlyEmojis)
        XCTAssertFalse(centerEmoji.containsOnlyEmojis)
        XCTAssertFalse(inlineEmojis.containsOnlyEmojis)
    }

    func testEmojisInStringReturnsAllEmojiCharactersInString() {
        XCTAssertEqual(noEmoji.emojis, [])
        XCTAssertEqual(emoji.emojis, ["👍"])
        XCTAssertEqual(emojis.emojis, ["🙂", "👍"])
        XCTAssertEqual(centerEmoji.emojis, ["👍"])
        XCTAssertEqual(inlineEmojis.emojis, ["🙂", "👍"])
    }

    func testEmojiScalarsInStringReturnsAllEmojiScalarsInString() {
        XCTAssertEqual(noEmoji.emojiScalars, [])
        XCTAssertEqual(emoji.emojiScalars, ["👍"])
        XCTAssertEqual(emojis.emojiScalars, ["🙂", "👍"])
        XCTAssertEqual(centerEmoji.emojiScalars, ["👍"])
        XCTAssertEqual(inlineEmojis.emojiScalars, ["🙂", "👍"])
    }

    func testEmojiStringReturnsAllEmojisInString() {
        XCTAssertEqual(noEmoji.emojiString, "")
        XCTAssertEqual(emoji.emojiString, "👍")
        XCTAssertEqual(emojis.emojiString, "🙂👍")
        XCTAssertEqual(centerEmoji.emojiString, "👍")
        XCTAssertEqual(inlineEmojis.emojiString, "🙂👍")
    }

    func testIsSingleEmojiReturnTrueForSingleEmojiString() {
        XCTAssertFalse(noEmoji.isSingleEmoji)
        XCTAssertTrue(emoji.isSingleEmoji)
        XCTAssertFalse(emojis.isSingleEmoji)
        XCTAssertFalse(centerEmoji.isSingleEmoji)
        XCTAssertFalse(inlineEmojis.isSingleEmoji)
    }
}
