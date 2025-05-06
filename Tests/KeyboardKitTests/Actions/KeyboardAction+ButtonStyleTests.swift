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

final class Keyboard_ButtonStyleTests {

    let context = KeyboardContext.preview

    @Test
    func actionIsUpperCasedShift() async throws {
        func result(for action: KeyboardAction) -> Bool {
            action.isUpperCasedShift(for: context)
        }
        context.keyboardCase = .lowercased
        #expect(result(for: .shift(.auto)) == false)
        context.keyboardCase = .uppercased
        #expect(result(for: .shift(.auto)) == true)
        context.keyboardCase = .capsLocked
        #expect(result(for: .shift(.auto)) == true)
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
    func actionHasStandardButtonFontSize() async throws {
        func result(for action: KeyboardAction) -> CGFloat? {
            action.standardButtonFontSize(for: context)
        }
        #expect(result(for: .keyboardType(.alphabetic)) == 15)
        #expect(result(for: .keyboardType(.numeric)) == 16)
        #expect(result(for: .keyboardType(.symbolic)) == 14)
        #expect(result(for: .keyboardType(.emojis)) == 20)
        #expect(result(for: .space) == 16)
        #expect(result(for: .text("")) == 16)
        #expect(result(for: .character("")) == nil)
        #expect(result(for: .backspace) == 20)
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
        var light: Color { .keyboardButtonForeground(for: context.colorScheme) }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == light)
        #expect(result(for: .primary(.continue)) == light)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == light)
        #expect(result(for: .shift(.auto)) == light)
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
