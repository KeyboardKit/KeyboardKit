//
//  KeyboardAction+ButtonStyleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Testing

@testable import KeyboardKit

@MainActor
final class Keyboard_ButtonStyleTests {

    let context = KeyboardContext()

    @Test
    func actionHasStandardButtonStyle() async throws {
        let action = KeyboardAction.backspace
        let style = action.standardButtonStyle(for: context, isPressed: false)
        #expect(style.backgroundColor == action.standardButtonBackgroundColor(for: context))
        #expect(style.foregroundColor == action.standardButtonForegroundColor(for: context))
        #expect(style.font == action.standardButtonFont(for: context).font)
        #expect(style.keyboardFont == action.standardButtonFont(for: context))
        #expect(style.cornerRadius == action.standardButtonCornerRadius(for: context))
        #expect(style.border == action.standardButtonBorderStyle(for: context))
        #expect(style.shadow == action.standardButtonShadowStyle(for: context))
    }

    @Test
    func actionHasStandardButtonBorderStyle() async throws {
        func result(for action: KeyboardAction) -> Keyboard.ButtonBorderStyle {
            action.standardButtonBorderStyle(for: context)
        }
        #expect(result(for: .character("")) == .standard)
        #expect(result(for: .backspace) == .standard)
        #expect(result(for: .emoji(.init(""))) == .noBorder)
        #expect(result(for: .none) == .noBorder)
    }

    @Test
    func actionHasStandardButtonContentInsets() async throws {
        func result(for action: KeyboardAction) -> EdgeInsets {
            action.standardButtonContentInsets(for: context)
        }
        #expect(result(for: .character("")) == .init(all: 3))
        #expect(result(for: .characterMargin("")) == .init(all: 0))
        #expect(result(for: .none) == .init(all: 0))
        "[](){}".chars.forEach { #expect(result(for: .character($0)).bottom == 6) }
        "<>".chars.forEach { #expect(result(for: .character($0)).bottom == 4) }
        context.deviceTypeForKeyboardIsIpadPro = true
        #expect(result(for: .character("")) == .init(all: 6))
        #expect(result(for: .characterMargin("")) == .init(all: 0))
        #expect(result(for: .none) == .init(all: 0))
    }

    @Test
    func actionHasStandardButtonCornerRadius() async throws {
        func result(for action: KeyboardAction) -> CGFloat {
            action.standardButtonCornerRadius(for: context)
        }
        context.deviceTypeForKeyboard = .phone
        context.interfaceOrientation = .portrait
        #expect(result(for: .character("")) == 5)
        context.interfaceOrientation = .landscape
        #expect(result(for: .character("")) == 5)
        context.deviceTypeForKeyboard = .pad
        context.interfaceOrientation = .portrait
        #expect(result(for: .character("")) == 5)
        context.interfaceOrientation = .landscape
        #expect(result(for: .character("")) == 7)
    }

    @Test
    func actionHasStandardButtonFont() async throws {
        func result(for action: KeyboardAction) -> KeyboardFont {
            action.standardButtonFont(for: context)
        }

        #expect(result(for: .backspace) == .system(size: 20, weight: .light))
        #expect(result(for: .keyboardType(.alphabetic)) == .system(size: 15))
    }

    @Test
    func actionHasStandardButtonFontSizeWithIpadOverrides() async throws {
        func result(for action: KeyboardAction) -> CGFloat? {
            action.standardButtonFontSize(for: context)
        }

        #expect(result(for: .keyboardType(.alphabetic)) == 15)
        #expect(result(for: .keyboardType(.numeric)) == 16)
        #expect(result(for: .keyboardType(.symbolic)) == 14)
        #expect(result(for: .keyboardType(.emojis)) == 20)
        #expect(result(for: .space) == 16)
        #expect(result(for: .text("")) == 16)
        #expect(result(for: .character("")) == 23)
        #expect(result(for: .backspace) == 20)

        #expect(result(for: .primary(.newLine)) == 20)      // Image
        #expect(result(for: .primary(.return)) == 16)

        #expect(result(for: .character("a")) == 26)
        #expect(result(for: .character("A")) == 23)

        context.locale = .swedish
        context.deviceTypeForKeyboardIsIpadPro = true
        #expect(result(for: .keyboardType(.alphabetic)) == 16)
        #expect(result(for: .keyboardType(.numeric)) == 16)
        #expect(result(for: .keyboardType(.symbolic)) == 16)
        #expect(result(for: .keyboardType(.emojis)) == 20)  // Image
        #expect(result(for: .tab) == 20)                    // Image
        #expect(result(for: .capsLock) == 20)               // Image
        #expect(result(for: .shift(.lowercased)) == 20)     // Image
        #expect(result(for: .backspace) == 20)              // Image
        #expect(result(for: .primary(.newLine)) == 20)      // Image

        context.locale = .swedish
        context.interfaceOrientation = .landscape
        context.deviceTypeForKeyboardIsIpadPro = true
        #expect(result(for: .keyboardType(.alphabetic)) == 20)
        #expect(result(for: .keyboardType(.numeric)) == 20)
        #expect(result(for: .keyboardType(.symbolic)) == 20)
        #expect(result(for: .keyboardType(.emojis)) == 20)  // Image
        #expect(result(for: .tab) == 20)                    // Image
        #expect(result(for: .capsLock) == 20)               // Image
        #expect(result(for: .shift(.lowercased)) == 20)     // Image
        #expect(result(for: .backspace) == 20)              // Image
        #expect(result(for: .primary(.newLine)) == 20)      // Image

        context.locale = .english
        context.interfaceOrientation = .portrait
        context.deviceTypeForKeyboardIsIpadPro = true
        #expect(result(for: .keyboardType(.alphabetic)) == 16)
        #expect(result(for: .keyboardType(.numeric)) == 16)
        #expect(result(for: .keyboardType(.symbolic)) == 16)
        #expect(result(for: .keyboardType(.emojis)) == 20)  // Image
        #expect(result(for: .tab) == 16)
        #expect(result(for: .capsLock) == 16)
        #expect(result(for: .shift(.lowercased)) == 16)
        #expect(result(for: .backspace) == 16)
        #expect(result(for: .primary(.newLine)) == 16)

        context.deviceTypeForKeyboard = .pad
        context.deviceTypeForKeyboardIsIpadPro = false
        context.interfaceOrientation = .portrait
        #expect(result(for: .keyboardType(.alphabetic)) == 15)
        #expect(result(for: .keyboardType(.numeric)) == 16)
        #expect(result(for: .keyboardType(.symbolic)) == 14)

        context.interfaceOrientation = .landscape
        #expect(result(for: .keyboardType(.alphabetic)) == 22)
        #expect(result(for: .keyboardType(.numeric)) == 22)
        #expect(result(for: .keyboardType(.symbolic)) == 20)
    }

    @Test
    func actionHasStandardButtonFontWeight() async throws {
        func result(for action: KeyboardAction) -> KeyboardFont.FontWeight? {
            action.standardButtonFontWeight(for: context)
        }
        #expect(result(for: .backspace) == .light)
        #expect(result(for: .character("a")) == .light)
        #expect(result(for: .character("A")) == nil)
        #expect(result(for: .character("!")) == nil)
        #expect(result(for: .primary(.newLine)) == .light)
    }

    @Test
    func actionHasStandardButtonShadowStyle() async throws {
        func result(for action: KeyboardAction) -> Keyboard.ButtonShadowStyle {
            action.standardButtonShadowStyle(for: context)
        }
        #expect(result(for: .character("")) == .standard)
        #expect(result(for: .backspace) == .standard)
        #expect(result(for: .characterMargin("")) == .noShadow)
        #expect(result(for: .emoji(.init(""))) == .noShadow)
        #expect(result(for: .none) == .noShadow)
        context.isSpaceDragGestureActive = true
        #expect(result(for: .character("")) == .noShadow)
        #expect(result(for: .backspace) == .noShadow)
    }
}
