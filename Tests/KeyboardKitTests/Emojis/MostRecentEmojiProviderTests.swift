//
//  MostRecentEmojiProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import XCTest

class MostRecentEmojiProviderTests: XCTestCase {

    var defaults: MockUserDefaults!
    var provider: MostRecentEmojiProvider!

    override func setUp() {
        defaults = MockUserDefaults()
        provider = MostRecentEmojiProvider(defaults: defaults)
    }


    func testMostRecentEmojisIsEmptyByDefault() {
        XCTAssertEqual(provider.emojis, [])
    }

    func testMostRecentEmojisReturnsAnythingStoredInDefaults() {
        let list = ["a", "b", "c"]
        defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
        XCTAssertEqual(provider.emojis.map { $0.char }, list)
    }


    func testRegisteringEmojiStoresNewEmojiFirstmostInUserDefaults() {
        let list = ["a", "b", "c"]
        defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
        provider.registerEmoji(Emoji("c"))
        let read = defaults.calls(to: \.stringArrayRef)
        let write = defaults.calls(to: \.setValueRef)
        XCTAssertEqual(read.count, 1)
        XCTAssertEqual(write.count, 1)
        XCTAssertEqual(write[0].arguments.0 as? [String], ["c", "a", "b"])
        XCTAssertEqual(write[0].arguments.1, read[0].arguments)
    }

    func testRegisteringEmojiCapsNewEmojiListToMaxCount() {
        let list = Array(repeating: "a", count: 100)
        defaults.registerResult(for: defaults.stringArrayRef) { _ in list }
        provider.registerEmoji(Emoji("c"))
        let calls = defaults.calls(to: \.setValueRef)
        let written = calls[0].arguments.0 as? [String]
        XCTAssertEqual(written?.count, 30)
    }
}
