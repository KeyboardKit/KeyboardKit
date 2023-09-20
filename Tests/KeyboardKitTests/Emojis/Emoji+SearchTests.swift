//
//  Emoji+SearchTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class Emoji_SearchTests: XCTestCase {

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

    func testCollectionItemsMatchingQueryMatchesOnCaseInsensitiveLocalizedName() {
        let emoji = Emoji("😀")
        XCTAssertTrue(emoji.matches("GrIn", for: .english))
        XCTAssertTrue(emoji.matches("lEende", for: .swedish))
    }
}
