//
//  EmojiStringAnalyzerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class EmojiStringAnalyzerTests: XCTestCase {

    class Analyzer: EmojiAnalyzer {}


    // MARK: - Character

    let combined = "☺️".char
    let nonCombined = "😀".char
    let simple = "😀".char
    let nonSimple = "⌚️".char

    func testIsEmojiReturnsTrueForAllEmojis() {
        let allEmojis = EmojiCategory.all.flatMap { $0.emojis }
        allEmojis.forEach {
            let char = $0.char.char
            XCTAssertTrue(char.isEmoji)
            XCTAssertTrue(analyzer.isEmoji(char))
        }
    }

    func testIsCombinedEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(combined.isCombinedEmoji)
        XCTAssertTrue(analyzer.isCombinedEmoji(combined))
        XCTAssertFalse(nonCombined.isCombinedEmoji)
        XCTAssertFalse(analyzer.isCombinedEmoji(nonCombined))
    }

    func testIsSimpleEmojiReturnsTrueForSimpleAndCombinedEmojis() {
        XCTAssertTrue(simple.isSimpleEmoji)
        XCTAssertTrue(analyzer.isSimpleEmoji(simple))
        XCTAssertFalse(nonSimple.isSimpleEmoji)
        XCTAssertFalse(analyzer.isSimpleEmoji(nonSimple))
    }


    // MARK: - String

    let analyzer = Analyzer()
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
        XCTAssertFalse(analyzer.containsEmoji(noEmoji))
        XCTAssertTrue(analyzer.containsEmoji(emoji))
        XCTAssertTrue(analyzer.containsEmoji(emojis))
        XCTAssertTrue(analyzer.containsEmoji(centerEmoji))
        XCTAssertTrue(analyzer.containsEmoji(inlineEmojis))
    }

    func testContainsOnlyEmojisReturnsTrueIfStringOnlyContainsEmojis() {
        XCTAssertFalse(noEmoji.containsOnlyEmojis)
        XCTAssertTrue(emoji.containsOnlyEmojis)
        XCTAssertTrue(emojis.containsOnlyEmojis)
        XCTAssertFalse(centerEmoji.containsOnlyEmojis)
        XCTAssertFalse(inlineEmojis.containsOnlyEmojis)
        XCTAssertFalse(analyzer.containsOnlyEmojis(noEmoji))
        XCTAssertTrue(analyzer.containsOnlyEmojis(emoji))
        XCTAssertTrue(analyzer.containsOnlyEmojis(emojis))
        XCTAssertFalse(analyzer.containsOnlyEmojis(centerEmoji))
        XCTAssertFalse(analyzer.containsOnlyEmojis(inlineEmojis))
    }

    func testEmojisInStringReturnsAllEmojiCharactersInString() {
        XCTAssertEqual(noEmoji.emojis, [])
        XCTAssertEqual(emoji.emojis, ["👍"])
        XCTAssertEqual(emojis.emojis, ["🙂", "👍"])
        XCTAssertEqual(centerEmoji.emojis, ["👍"])
        XCTAssertEqual(inlineEmojis.emojis, ["🙂", "👍"])
        XCTAssertEqual(analyzer.emojis(in: noEmoji), [])
        XCTAssertEqual(analyzer.emojis(in: emoji), ["👍"])
        XCTAssertEqual(analyzer.emojis(in: emojis), ["🙂", "👍"])
        XCTAssertEqual(analyzer.emojis(in: centerEmoji), ["👍"])
        XCTAssertEqual(analyzer.emojis(in: inlineEmojis), ["🙂", "👍"])
    }

    func testEmojiScalarsInStringReturnsAllEmojiScalarsInString() {
        XCTAssertEqual(noEmoji.emojiScalars, [])
        XCTAssertEqual(emoji.emojiScalars, ["👍"])
        XCTAssertEqual(emojis.emojiScalars, ["🙂", "👍"])
        XCTAssertEqual(centerEmoji.emojiScalars, ["👍"])
        XCTAssertEqual(inlineEmojis.emojiScalars, ["🙂", "👍"])
        XCTAssertEqual(analyzer.emojiScalars(in: noEmoji), [])
        XCTAssertEqual(analyzer.emojiScalars(in: emoji), ["👍"])
        XCTAssertEqual(analyzer.emojiScalars(in: emojis), ["🙂", "👍"])
        XCTAssertEqual(analyzer.emojiScalars(in: centerEmoji), ["👍"])
        XCTAssertEqual(analyzer.emojiScalars(in: inlineEmojis), ["🙂", "👍"])
    }

    func testEmojiStringReturnsAllEmojisInString() {
        XCTAssertEqual(noEmoji.emojiString, "")
        XCTAssertEqual(emoji.emojiString, "👍")
        XCTAssertEqual(emojis.emojiString, "🙂👍")
        XCTAssertEqual(centerEmoji.emojiString, "👍")
        XCTAssertEqual(inlineEmojis.emojiString, "🙂👍")
        XCTAssertEqual(analyzer.emojiString(in: noEmoji), "")
        XCTAssertEqual(analyzer.emojiString(in: emoji), "👍")
        XCTAssertEqual(analyzer.emojiString(in: emojis), "🙂👍")
        XCTAssertEqual(analyzer.emojiString(in: centerEmoji), "👍")
        XCTAssertEqual(analyzer.emojiString(in: inlineEmojis), "🙂👍")
    }

    func testIsSingleEmojiReturnTrueForSingleEmojiString() {
        XCTAssertFalse(noEmoji.isSingleEmoji)
        XCTAssertTrue(emoji.isSingleEmoji)
        XCTAssertFalse(emojis.isSingleEmoji)
        XCTAssertFalse(centerEmoji.isSingleEmoji)
        XCTAssertFalse(inlineEmojis.isSingleEmoji)
        XCTAssertFalse(analyzer.isSingleEmoji(noEmoji))
        XCTAssertTrue(analyzer.isSingleEmoji(emoji))
        XCTAssertFalse(analyzer.isSingleEmoji(emojis))
        XCTAssertFalse(analyzer.isSingleEmoji(centerEmoji))
        XCTAssertFalse(analyzer.isSingleEmoji(inlineEmojis))
    }
}

private extension String {

    var char: Character { Array(self)[0] }
}
