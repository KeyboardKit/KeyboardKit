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

    class Analyzer: EmojiCharacterAnalyzer {}

    let analyzer = Analyzer()
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
}

private extension String {

    var char: Character { Array(self)[0] }
}
