//
//  Color+StandardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Testing

@testable import KeyboardKit

@MainActor
final class Color_StandardTests {

    let context = KeyboardContext()

    @Test
    func hasStandardButtonBackgroundColor() async throws {
        let action = KeyboardAction.character("")
        let color = Color.standardKeyboardButtonBackground(for: context, action: action)
        let opacity = Color.standardKeyboardButtonBackgroundOpacity(for: context, action: action, isPressed: false)
        let value = Color.standardKeyboardButtonBackgroundValue(for: context, action: action, isPressed: false)
        #expect(color == value.opacity(opacity))
    }

    @Test
    func hasStandardButtonBackgroundColorForCapsLock() async throws {
        func result(for action: KeyboardAction, _ pressed: Bool) -> Color {
            Color.standardKeyboardButtonBackground(for: context, action: action, isPressed: pressed)
        }
        context.keyboardCase = .capsLocked
        #expect(result(for: .capsLock, false) == result(for: .backspace, true))
        #expect(result(for: .shift(.auto), false) == result(for: .backspace, false))
    }

    @Test
    func hasStandardButtonBackgroundColorOpacity() async throws {
        func result(for action: KeyboardAction, _ pressed: Bool) -> Double {
            Color.standardKeyboardButtonBackgroundOpacity(for: context, action: action, isPressed: pressed)
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
    func hasStandardButtonBackgroundColorValue() async throws {
        func result(for action: KeyboardAction) -> Color {
            Color.standardKeyboardButtonBackgroundValue(for: context, action: action, isPressed: false)
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
    func hasStandardButtonBackgroundColorValueForPressedState() async throws {
        func result(for action: KeyboardAction) -> Color {
            Color.standardKeyboardButtonBackgroundValue(for: context, action: action, isPressed: true)
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
    func hasStandardButtonForegroundColor() async throws {
        func result(for action: KeyboardAction) -> Color {
            Color.standardKeyboardButtonForeground(for: context, action: action)
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
    func hasStandardButtonForegroundColorForPressedState() async throws {
        func result(for action: KeyboardAction) -> Color {
            Color.standardKeyboardButtonForeground(for: context, action: action, isPressed: true)
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
}
