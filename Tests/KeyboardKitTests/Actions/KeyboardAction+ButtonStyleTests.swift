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
    func actionHasStandardButtonBackgroundColor() async throws {
        let action = KeyboardAction.character("")
        let color = action.standardButtonBackgroundColor(for: context)
        let opacity = action.standardButtonBackgroundColorOpacity(for: context)
        let value = action.standardButtonBackgroundColorValue(for: context)
        #expect(color == value.opacity(opacity))
    }

    @Test
    func actionHasStandardButtonBackgroundColorForCapsLock() async throws {
        func result(for action: KeyboardAction, _ pressed: Bool) -> Color {
            action.standardButtonBackgroundColor(for: context, isPressed: pressed)
        }
        context.keyboardCase = .capsLocked
        #expect(result(for: .capsLock, false) == result(for: .backspace, true))
        #expect(result(for: .shift(.auto), false) == result(for: .backspace, false))
    }

    @Test
    func actionHasStandardButtonBackgroundColorOpacity() async throws {
        func result(for action: KeyboardAction, _ pressed: Bool) -> Double {
            action.standardButtonBackgroundColorOpacity(for: context, isPressed: pressed)
        }
        context.isSpaceDragGestureActive = true
        #expect(result(for: .primary(.continue), false) == 1.0)
        #expect(result(for: .character("a"), true) == 0.5)
        #expect(result(for: .character("a"), false) == 0.5)
        context.isSpaceDragGestureActive = false
        #expect(result(for: .primary(.continue), false) == 1.0)
        #expect(result(for: .character("a"), true) == 1.0)
        #expect(result(for: .character("a"), false) == 0.95)
        context.colorScheme = .dark
        #expect(result(for: .primary(.continue), false) == 1.0)
        #expect(result(for: .character("a"), true) == 1.0)
        #expect(result(for: .character("a"), false) == 1.0)
    }

    @Test
    func actionHasStandardButtonBackgroundColorValue() async throws {
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonBackgroundColorValue(for: context)
        }
        var light: Color { .keyboardButtonBackground(for: context.colorScheme) }
        var dark: Color { .keyboardDarkButtonBackground(for: context.colorScheme) }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == dark)
        #expect(result(for: .primary(.continue)) == .blue)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == dark)
        #expect(result(for: .primary(.continue)) == .blue)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.keyboardCase = .uppercased
        context.colorScheme = .light
        #expect(result(for: .shift(.auto)) == light)
        context.colorScheme = .dark
        #expect(result(for: .shift(.auto)) == .white)
    }

    @Test
    func actionHasStandardButtonBackgroundColorValueForPressedState() async throws {
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonBackgroundColorValue(for: context, isPressed: true)
        }
        var light: Color { .keyboardButtonBackground(for: context.colorScheme) }
        var dark: Color { .keyboardDarkButtonBackground(for: context.colorScheme) }
        context.keyboardCase = .lowercased
        context.colorScheme = .light
        #expect(result(for: .character("a")) == dark)
        #expect(result(for: .shift(.auto)) == .white)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == dark)
        #expect(result(for: .shift(.auto)) == light)
        #expect(result(for: .primary(.continue)) == dark)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.keyboardCase = .uppercased
        context.colorScheme = .light
        #expect(result(for: .shift(.auto)) == dark)
        context.colorScheme = .dark
        #expect(result(for: .shift(.auto)) == dark)
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
    func actionHasStandardButtonForegroundColor() async throws {
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonForegroundColor(for: context)
        }
        var light: Color { .keyboardButtonForeground(for: context.colorScheme) }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == light)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == light)
        #expect(result(for: .primary(.continue)) == .white)
        context.keyboardCase = .uppercased
        #expect(result(for: .shift(.auto)) == .black)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
    }

    @Test
    func actionHasStandardButtonForegroundColorForPressedState() async throws {
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonForegroundColor(for: context, isPressed: true)
        }
        var foregroundLightMode: Color { .keyboardButtonForeground(for: .light) }
        var foregroundDarkMode: Color { .keyboardButtonForeground(for: .dark) }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == foregroundLightMode)
        #expect(result(for: .shift(.auto)) == foregroundLightMode)
        #expect(result(for: .primary(.continue)) == foregroundLightMode)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == foregroundDarkMode)
        #expect(result(for: .shift(.auto)) == foregroundDarkMode)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
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
