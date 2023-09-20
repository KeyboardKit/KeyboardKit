//
//  Emoji+LocalizationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

/**
 You can use this test case to get a list of all emojis that
 are missing translations for a certain keyboard locale.

 To use the test case class as a tool, just do the following:

 1. Run just the `testLocalizedNameForAllEmojis` test.
 2. Set the `locale` to the locale you want to localize.
 3. If any emoji is not translated, the test will fail.
 4. If the tests fail, you get a print with the missing ones.
 5. Find the locale's `Localizable.strings` under `Resources`.
 6. Paste the string and add the correct localized names.

 When the test case passes, all emojis are localized for the
 specified locale.
 */
final class Emoji_LocalizationTests: XCTestCase {

    func testLocalizationKeyIsKeyIdPrefixedWithEmoji() {
        let value = Emoji("😀").localizationKey
        XCTAssertEqual(value, "Emoji.GrinningFace")
    }

    func testLocalizationKeyIdIsUnicodeNameWithSpacesRemoved() {
        let value = Emoji("😀").localizationKeyId
        XCTAssertEqual(value, "GrinningFace")
    }

    func testLocalizedNameIsValidForManyLocales() {
        let emoji = Emoji("😀")
        XCTAssertEqual(emoji.localizedName(for: .english), "Grinning Face")
        XCTAssertEqual(emoji.localizedName(for: .swedish), "Leende ansikte")
        XCTAssertEqual(emoji.localizedName(for: .norwegian), "Grinning Face")
        let ring = Emoji("💍")
        XCTAssertEqual(ring.localizedName(for: .english), "Ring")
    }
}
