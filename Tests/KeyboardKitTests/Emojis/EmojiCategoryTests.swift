//
//  EmojiCategoryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class EmojiCategoryTests: XCTestCase {

    func fallbackEmoji(for category: EmojiCategory) -> String {
        category.fallbackDisplayEmoji.char
    }

    func firstEmoji(for category: EmojiCategory) -> String {
        category.emojis[0].char
    }

    func firstEmojiAction(for category: EmojiCategory) -> KeyboardAction {
        category.emojiActions[0]
    }
    
    func testEmojiCategoryHasDefaultSortOrder() {
        XCTAssertEqual(EmojiCategory.all, [
            .frequent,
            .smileys,
            .animals,
            .foods,
            .activities,
            .travels,
            .objects,
            .symbols,
            .flags
        ])
    }

    func testEmojiCategoryHasFallbackDisplayEmoji() {
        XCTAssertEqual(fallbackEmoji(for: .frequent), "🕓")
        XCTAssertEqual(fallbackEmoji(for: .smileys), "😀")
        XCTAssertEqual(fallbackEmoji(for: .animals), "🐻")
        XCTAssertEqual(fallbackEmoji(for: .foods), "🍔")
        XCTAssertEqual(fallbackEmoji(for: .activities), "⚽️")
        XCTAssertEqual(fallbackEmoji(for: .travels), "🚗")
        XCTAssertEqual(fallbackEmoji(for: .objects), "💡")
        XCTAssertEqual(fallbackEmoji(for: .symbols), "💱")
        XCTAssertEqual(fallbackEmoji(for: .flags), "🏳️")
    }

    func testEmojiCategoryContainsCorrectEmojis() {
        XCTAssertEqual(firstEmoji(for: .activities), "⚽️")
        XCTAssertEqual(firstEmoji(for: .animals), "🐶")
        XCTAssertEqual(firstEmoji(for: .flags), "🏳️")
        XCTAssertEqual(firstEmoji(for: .foods), "🍏")
        XCTAssertEqual(firstEmoji(for: .objects), "⌚️")
        XCTAssertEqual(firstEmoji(for: .smileys), "😀")
        XCTAssertEqual(firstEmoji(for: .symbols), "❤️")
        XCTAssertEqual(firstEmoji(for: .travels), "🚗")
    }

    func testEmojiCategoryContainsCorrectEmojiSet() {
        XCTAssertEqual(firstEmojiAction(for: .activities), .emoji(Emoji("⚽️")))
        XCTAssertEqual(firstEmojiAction(for: .animals), .emoji(Emoji("🐶")))
        XCTAssertEqual(firstEmojiAction(for: .flags), .emoji(Emoji("🏳️")))
        XCTAssertEqual(firstEmojiAction(for: .foods), .emoji(Emoji("🍏")))
        XCTAssertEqual(firstEmojiAction(for: .objects), .emoji(Emoji("⌚️")))
        XCTAssertEqual(firstEmojiAction(for: .smileys), .emoji(Emoji("😀")))
        XCTAssertEqual(firstEmojiAction(for: .symbols), .emoji(Emoji("❤️")))
        XCTAssertEqual(firstEmojiAction(for: .travels), .emoji(Emoji("🚗")))
    }
}
