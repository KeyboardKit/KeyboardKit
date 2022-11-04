//
//  KeyboardActionsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardActionsTests: XCTestCase {

    func testCanCreateKeyboardActionsFromStringArrays() {
        let chars = ["a", "b", "c"]
        let row = KeyboardActions(characters: chars)
        XCTAssertEqual(row.count, 3)
        XCTAssertEqual(row[0], .character("a"))
        XCTAssertEqual(row[1], .character("b"))
        XCTAssertEqual(row[2], .character("c"))
    }

    func testCanCreateKeyboardActionsFromImages() {

        func verify(
            _ action: KeyboardAction,
            _ imageName: String,
            _ keyboardImageName: String,
            _ description: String) -> Bool {
            switch action {
            case .image(let imageName, let keyboardImageName, let description):
                return imageName == imageName
                    && keyboardImageName == keyboardImageName
                    && description == description
            default: return false
            }
        }

        let actions = KeyboardActions(
            imageNames: ["1", "2", "3"],
            keyboardImageNamePrefix: "pre-",
            keyboardImageNameSuffix: "-suf",
            localizationKeyPrefix: "a-",
            localizationKeySuffix: "-b",
            throwAssertionFailure: false)

        XCTAssertEqual(actions.count, 3)
        XCTAssertTrue(verify(actions[0], "1", "pre-1-suf", "a-1-b"))
        XCTAssertTrue(verify(actions[1], "2", "pre-2-suf", "a-2-b"))
        XCTAssertTrue(verify(actions[2], "3", "pre-3-suf", "a-3-b"))
    }
}
