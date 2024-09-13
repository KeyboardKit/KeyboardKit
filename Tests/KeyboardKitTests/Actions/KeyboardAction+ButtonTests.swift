//
//  KeyboardAction+ImagesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

final class KeyboardAction_ImagesTests: XCTestCase {

    let actions = KeyboardAction.testActions
    var context = KeyboardContext()

    var expected: [KeyboardAction]! {
        didSet { unexpected = actions.filter { !expected.contains($0) } }
    }

    var unexpected: [KeyboardAction]!

    override func setUp() {
        expected = []
        unexpected = []
    }

    func testStandardButtonImageIsDefinedForSomeActions() {

        func result(for action: KeyboardAction) -> Any? {
            action.standardButtonImage(for: context)
        }

        expected = [
            .backspace,
            .capsLock,
            .command,
            .control,
            .dictation,
            .dismissKeyboard,
            .image(description: "", keyboardImageName: "", imageName: ""),
            .keyboardType(.email),
            .keyboardType(.emojis),
            .keyboardType(.images),
            .moveCursorBackward,
            .moveCursorForward,
            .nextKeyboard,
            .option,
            .primary(.newLine),
            .settings,
            .shift(currentCasing: .lowercased),
            .shift(currentCasing: .uppercased),
            .shift(currentCasing: .capsLocked),
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .systemSettings,
            .tab,
            .url(URL(string: ""))
        ]

        expected.forEach { XCTAssertNotNil(result(for: $0)) }
        unexpected.forEach { XCTAssertNil(result(for: $0)) }
    }

    func testStandardButtonTextIsDefinedForSomeActions() {

        func result(for action: KeyboardAction) -> Int? {
            action.standardButtonText(for: context)?.count
        }

        XCTAssertTrue(result(for: .character("A"))! > 0)
        XCTAssertTrue(result(for: .emoji(Emoji("🛸")))! > 0)

        XCTAssertTrue(result(for: .keyboardType(.alphabetic(.capsLocked)))! > 0)
        XCTAssertTrue(result(for: .keyboardType(.alphabetic(.lowercased)))! > 0)
        XCTAssertTrue(result(for: .keyboardType(.alphabetic(.uppercased)))! > 0)
        XCTAssertTrue(result(for: .keyboardType(.numeric))! > 0)
        XCTAssertTrue(result(for: .keyboardType(.symbolic))! > 0)
        XCTAssertNil(result(for: .keyboardType(.custom(named: ""))))

        XCTAssertTrue(result(for: .nextLocale)! > 0)

        XCTAssertTrue(result(for: .primary(.return))! > 0)
        XCTAssertTrue(result(for: .primary(.done))! > 0)
        XCTAssertTrue(result(for: .primary(.go))! > 0)
        XCTAssertTrue(result(for: .primary(.ok))! > 0)
        XCTAssertTrue(result(for: .primary(.search))! > 0)

        XCTAssertTrue(result(for: .space)! > 0)

        XCTAssertNil(result(for: .none))
        XCTAssertNil(result(for: .backspace))
        XCTAssertNil(result(for: .command))
        XCTAssertNil(result(for: .control))
        XCTAssertNil(result(for: .custom(named: "")))
        XCTAssertNil(result(for: .dictation))
        XCTAssertNil(result(for: .dismissKeyboard))
        XCTAssertNil(result(for: .escape))
        XCTAssertNil(result(for: .function))
        XCTAssertNil(result(for: .keyboardType(.email)))
        XCTAssertNil(result(for: .keyboardType(.images)))
        XCTAssertNil(result(for: .moveCursorBackward))
        XCTAssertNil(result(for: .moveCursorForward))
        XCTAssertNil(result(for: .nextKeyboard))
        XCTAssertNil(result(for: .option))
        XCTAssertNil(result(for: .primary(.newLine)))
        XCTAssertNil(result(for: .shift(currentCasing: .lowercased)))
        XCTAssertNil(result(for: .shift(currentCasing: .uppercased)))
        XCTAssertNil(result(for: .shift(currentCasing: .capsLocked)))
        XCTAssertNil(result(for: .tab))
    }
}
