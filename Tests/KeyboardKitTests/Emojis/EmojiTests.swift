//
//  EmojiCategoryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import XCTest

final class EmojiTests: XCTestCase {

    func testEmojiUsesCharAsUniqueIdentifier() {
        Emoji.all.forEach {
            XCTAssertEqual($0.id, $0.char)
        }
    }

    func testUnicodeIdentifierIsRawValue() {
        let id = Emoji("😀").unicodeIdentifier
        XCTAssertEqual(id, "\\N{GRINNING FACE}")
    }

    func testUnicodeIdentifierIsDefinedForAllEmojis() {
        Emoji.all.forEach {
            XCTAssertNotNil($0.unicodeIdentifier)
        }
    }

    func testUnicodeNameIsCleanedUpIdentifier() {
        let name = Emoji("😀").unicodeName
        XCTAssertEqual(name, "Grinning Face")
    }

    func testUnicodeNameIsDefinedForAllEmojis() {
        Emoji.all.forEach {
            XCTAssertNotNil($0.unicodeName)
        }
    }
}
