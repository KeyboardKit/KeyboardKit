//
//  KeyboardAction+ButtonContentTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

final class KeyboardAction_ButtonContentTests: XCTestCase {

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

    func testStandardButtonImageIsSpecialForCapsLock() {
        func result(for action: KeyboardAction) -> Image? {
            action.standardButtonImage(for: context)
        }
        context.keyboardCase = .uppercased
        XCTAssertEqual(result(for: .capsLock), .keyboardShiftCapslockInactive)
        XCTAssertEqual(result(for: .shift(.uppercased)), .keyboardShiftUppercased)
        context.keyboardCase = .capsLocked
        XCTAssertEqual(result(for: .capsLock), .keyboardShiftCapslocked)
        XCTAssertEqual(result(for: .shift(.uppercased)), .keyboardShiftLowercased)
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
            .shift(.auto),
            .systemImage(description: "", keyboardImageName: "", imageName: ""),
            .systemSettings,
            .tab,
            .url(URL(string: ""))
        ]

        expected.forEach { XCTAssertNotNil(result(for: $0)) }
        unexpected.forEach { XCTAssertNil(result(for: $0)) }
    }

    func testStandardButtonImageScaleIsDeviceSpecific() {
        let action = KeyboardAction.space
        context.deviceTypeForKeyboard = .phone
        XCTAssert(action.standardButtonImageScale(for: context) == 1)
        context.deviceTypeForKeyboard = .pad
        XCTAssert(action.standardButtonImageScale(for: context) == 1.2)
    }

    func testStandardButtonTextIsDefinedForSomeActions() {
        func result(for action: KeyboardAction) -> Int? {
            action.standardButtonText(for: context)?.count
        }

        XCTAssertTrue(result(for: .character("A"))! > 0)
        XCTAssertTrue(result(for: .emoji(Emoji("🛸")))! > 0)

        XCTAssertTrue(result(for: .keyboardType(.alphabetic))! > 0)
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
        XCTAssertNil(result(for: .shift(.auto)))
        XCTAssertNil(result(for: .tab))
    }
}
