//
//  Emoji+LocalizationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import XCTest

/**
 You can use this test case to get a list of all emojis that
 still are missing translations for a certain locale.

 To use the test case class as a tool, just do the following:

 1. Set the `locale` to the locale you want to localize.
 2. Run just this test case by tapping the diamond shape.
 3. If any emoji is not translated, the tests will fail.
 4. If the tests fail, you get a print with the missing ones.
 5. Find the locale's `Localizable.strings` under `Resources`.
 6. Paste the string and add the correct localized names.

 When the test case passes, all emojis are localized for the
 specified locale.
 */
class Emoji_LocalizationTests: XCTestCase {

    let locale = KeyboardLocale.english

    func testLocalizationKey() {
        let emoji = Emoji("😀")
        let id = emoji.localizationKey
        XCTAssertEqual(id, "Emoji.GrinningFace")
    }

    func testLocalizationKeyId() {
        let emoji = Emoji("😀")
        let id = emoji.localizationKeyId
        XCTAssertEqual(id, "GrinningFace")
    }

    func testLocalizedNameForLocale() {
        let emojis = EmojiCategory.all.flatMap { $0.emojis }
        let untranslated = emojis.filter { $0.localizationKey != ($0.unicodeName ?? "") }
        let isEnglish = locale.rawValue.hasPrefix("en")
        let success = isEnglish || untranslated.count == 0
        XCTAssertTrue(success)
        if !success {
            print("\n COPY AND TRANSLATE THESE \n")
            untranslated.forEach {
                print("/* \($0.char)] */ \"\($0.localizationKey)\" = \"\";")
            }
        }
    }
}
