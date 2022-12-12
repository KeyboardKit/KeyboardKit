//
//  EmojiCategoryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Emoji_UnicodeTests: XCTestCase {

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

    func testUnicodeNameIsOverrideIfAvailable() {
        let name = Emoji("🇰🇪").unicodeName
        XCTAssertEqual(name, "Flag - Kenya")
    }

    func testUnicodeNameIsDefinedForAllEmojis() {
        Emoji.all.forEach {
            XCTAssertNotNil($0.unicodeName)
        }
    }

    func testUnicodeNameOverrideIsOnlyDefinedForFlags() {
        XCTAssertNil(Emoji("😀").unicodeNameOverride)
        XCTAssertNotNil(Emoji("🇳🇴").unicodeNameOverride)
        Emoji.all.forEach {
            if let name = $0.unicodeNameOverride {
                XCTAssertTrue(name.contains("Flag"))
            }
        }
    }
}
