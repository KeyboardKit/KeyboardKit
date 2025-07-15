//
//  KeyboardAction+ButtonImageTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import Testing

@MainActor
final class KeyboardAction_ButtonImageTests {

    let actions = KeyboardAction.testActions
    var context = KeyboardContext()

    var expected: [KeyboardAction] = [] {
        didSet { unexpected = actions.filter { !expected.contains($0) } }
    }

    var unexpected: [KeyboardAction] = []

    @Test
    func standardButtonImageIsSpecialForCapsLock() {
        func result(for action: KeyboardAction) -> Image? {
            action.standardButtonImage(for: context)
        }

        // Test uppercase case
        context.keyboardCase = .uppercased
        #expect(result(for: .capsLock) == .keyboardShiftCapslockInactive)
        #expect(result(for: .shift(.uppercased)) == .keyboardShiftUppercased)

        // Test caps locked case (standard)
        context.keyboardCase = .capsLocked
        #expect(result(for: .capsLock) == .keyboardShiftCapslockActive)
        #expect(result(for: .shift(.uppercased)) == .keyboardShiftCapslockActive)

        // Test caps locked case (iPad Pro - English)
        context.deviceTypeForKeyboardIsIpadPro = true
        context.locale = .english
        #expect(result(for: .capsLock) == nil)
        #expect(result(for: .shift(.uppercased)) == nil)

        // Test caps locked case (iPad Pro - Swedish)
        context.deviceTypeForKeyboardIsIpadPro = true
        context.locale = .swedish
        #expect(result(for: .capsLock) == .keyboardShiftCapslockActive)
        #expect(result(for: .shift(.uppercased)) == .keyboardShiftLowercased)
    }

    @Test
    func standardButtonImageIsDefinedForSomeActions() {
        func result(for action: KeyboardAction) -> Any? {
            action.standardButtonImage(for: context)
        }

        // Reset the expected actions
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

        // Test expected actions have images
        for action in expected {
            #expect(result(for: action) != nil)
        }

        // Test unexpected actions don't have images
        for action in unexpected {
            #expect(result(for: action) == nil)
        }
    }

    @Test
    func standardButtonImageScaleIsDeviceSpecific() {
        let action = KeyboardAction.space

        // Test phone scale
        context.deviceTypeForKeyboard = .phone
        #expect(action.standardButtonImageScale(for: context) == 1)

        // Test pad scale
        context.deviceTypeForKeyboard = .pad
        #expect(action.standardButtonImageScale(for: context) == 1.2)
    }

    @Test
    func standardButtonImageIsRemovedOnEnglishIpadProForSomeActions() {

        /// The iPad Pro texts are so far not localized
        func result(for action: KeyboardAction) -> Image? {
            action.standardButtonImage(for: context)
        }

        #expect(result(for: .tab) != nil)
        #expect(result(for: .capsLock) != nil)
        #expect(result(for: .shift(.lowercased)) != nil)
        #expect(result(for: .backspace) != nil)
        #expect(result(for: .primary(.newLine)) != nil)

        context.locale = .swedish
        context.deviceTypeForKeyboardIsIpadPro = true

        #expect(result(for: .tab) != nil)
        #expect(result(for: .capsLock) != nil)
        #expect(result(for: .shift(.lowercased)) != nil)
        #expect(result(for: .backspace) != nil)
        #expect(result(for: .primary(.newLine)) != nil)

        context.locale = .english

        #expect(result(for: .tab) == nil)
        #expect(result(for: .capsLock) == nil)
        #expect(result(for: .shift(.lowercased)) == nil)
        #expect(result(for: .backspace) == nil)
        #expect(result(for: .primary(.newLine)) == nil)
    }
}
