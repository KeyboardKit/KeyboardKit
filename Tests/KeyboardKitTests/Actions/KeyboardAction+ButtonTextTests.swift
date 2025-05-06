//
//  KeyboardAction+ButtonTextTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import Testing

@MainActor
final class KeyboardAction_ButtonTextTests {

    let actions = KeyboardAction.testActions
    var context = KeyboardContext()

    @Test
    func standardButtonTextIsDefinedForSomeActions() throws {

        // We don't check the actual text since it can be localized
        func hasResult(for action: KeyboardAction) -> Bool {
            let result = action.standardButtonText(for: context)
            guard let result else { return false }
            return result.count > 0
        }

        // Character and emoji actions should have text
        #expect(hasResult(for: .character("A")))
        #expect(hasResult(for: .emoji(Emoji("🛸"))))

        // Standard keyboard type actions should have text
        #expect(hasResult(for: .keyboardType(.alphabetic)))
        #expect(hasResult(for: .keyboardType(.numeric)))
        #expect(hasResult(for: .keyboardType(.symbolic)))
        #expect(!hasResult(for: .keyboardType(.custom(named: ""))))

        // Locale action should have text
        #expect(hasResult(for: .nextLocale))

        // Primary actions should have text
        #expect(hasResult(for: .primary(.return)))
        #expect(hasResult(for: .primary(.done)))
        #expect(hasResult(for: .primary(.go)))
        #expect(hasResult(for: .primary(.ok)))
        #expect(hasResult(for: .primary(.search)))

        // Space should have text
        #expect(hasResult(for: .space))

        // These actions should not have text
        #expect(!hasResult(for: .none))
        #expect(!hasResult(for: .backspace))
        #expect(!hasResult(for: .command))
        #expect(!hasResult(for: .control))
        #expect(!hasResult(for: .custom(named: "")))
        #expect(!hasResult(for: .dictation))
        #expect(!hasResult(for: .dismissKeyboard))
        #expect(!hasResult(for: .escape))
        #expect(!hasResult(for: .function))
        #expect(!hasResult(for: .keyboardType(.email)))
        #expect(!hasResult(for: .keyboardType(.images)))
        #expect(!hasResult(for: .moveCursorBackward))
        #expect(!hasResult(for: .moveCursorForward))
        #expect(!hasResult(for: .nextKeyboard))
        #expect(!hasResult(for: .option))
        #expect(!hasResult(for: .primary(.newLine)))
        #expect(!hasResult(for: .shift(.auto)))
        #expect(!hasResult(for: .tab))
    }

    @Test
    func standardButtonTextIsDefinedOnEnglishIpadProForSomeActions() {

        /// The iPad Pro texts are so far not localized
        func result(for action: KeyboardAction) -> String? {
            action.standardButtonText(for: context)
        }

        #expect(result(for: .tab) == nil)
        #expect(result(for: .capsLock) == nil)
        #expect(result(for: .shift(.lowercased)) == nil)
        #expect(result(for: .backspace) == nil)
        #expect(result(for: .primary(.newLine)) == nil)
        #expect(result(for: .none) == nil)

        context.locale = .swedish
        context.deviceTypeForKeyboardIsIpadPro = true

        #expect(result(for: .tab) == nil)
        #expect(result(for: .capsLock) == nil)
        #expect(result(for: .shift(.lowercased)) == nil)
        #expect(result(for: .backspace) == nil)
        #expect(result(for: .primary(.newLine)) == nil)
        #expect(result(for: .none) == nil)

        context.locale = .english

        #expect(result(for: .tab) == "tab")
        #expect(result(for: .capsLock) == "caps lock")
        #expect(result(for: .shift(.lowercased)) == "shift")
        #expect(result(for: .backspace) == "delete")
        #expect(result(for: .primary(.newLine)) == "return")
        #expect(result(for: .none) == nil)
    }
}
