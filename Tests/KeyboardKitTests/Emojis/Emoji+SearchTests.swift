//
//  Emoji+SearchTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Emoji_SearchTests: XCTestCase {

    func testMatchesQueryMatchesOnCaseInsensitiveUnicodeName() {
        let emoji = Emoji("😀")
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("GrIn", for: .swedish))
    }

    func testMatchesQueryMatchesOnCaseInsensitiveLocalizedName() {
        let emoji = Emoji("😀")
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("lEende", for: .swedish))
    }

    func testCollectionItemsMatchingQueryMatchesOnCaseInsensitiveUnicodeName() {
        let emojis = Emoji.all.matching("GrIn", for: .english)
        let mapped = emojis.map { $0.char }
        XCTAssertEqual(mapped, ["😀", "😁", "🤪", "🤩", "😸"])
    }

    func testCollectionItemsMatchingQueryMatchesOnCaseInsensitiveLocalizedName() {
        let emoji = Emoji("😀")
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("lEende", for: .swedish))
    }
}
