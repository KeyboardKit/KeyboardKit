//
//  Emoji+UnicodeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Emoji_UnicodeTests: XCTestCase {
    
    func testUnicodeIdentifierIsRawValue() {
        let id = Emoji("😀").unicodeIdentifier
        XCTAssertEqual(id, "\\N{GRINNING FACE}")
    }

    func testUnicodeNameIsCleanedUpIdentifier() {
        let emoji = Emoji("😀")
        XCTAssertEqual(emoji.unicodeName, "Grinning Face")
        let ring = Emoji("💍")
        XCTAssertEqual(ring.unicodeName, "Ring")
    }

    func testUnicodeNameIsOverrideIfAvailable() {
        let name = Emoji("🇰🇪").unicodeName
        XCTAssertEqual(name, "Flag - Kenya")
    }

    func testUnicodeNameOverrideIsOnlyDefinedForFlags() {
        XCTAssertNil(Emoji("😀").unicodeNameOverride)
        XCTAssertNotNil(Emoji("🇳🇴").unicodeNameOverride)
    }
}
