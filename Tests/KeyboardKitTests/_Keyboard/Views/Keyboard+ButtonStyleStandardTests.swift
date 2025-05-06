//
//  Keyboard+ButtonStyleStandardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Testing

@testable import KeyboardKit

final class Keyboard_ButtonStyleStandardTests {

    @Test
    func keyboardActionIsUpperCasedShift() async throws {
        let context = KeyboardContext.preview
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
    func keyboardActionHasStandardButtonBackgroundColorForCapsLock() async throws {
        let context = KeyboardContext.preview
        func result(for action: KeyboardAction, _ pressed: Bool) -> Color {
            action.standardButtonBackgroundColor(for: context, isPressed: pressed)
        }
        context.keyboardCase = .capsLocked
        #expect(result(for: .capsLock, false) == result(for: .backspace, true))
        #expect(result(for: .shift(.auto), false) == result(for: .backspace, false))
    }

    @Test
    func keyboardActionHasStandardButtonBackgroundColor() async throws {
        let context = KeyboardContext.preview
        let action = KeyboardAction.character("")
        let color = action.standardButtonBackgroundColor(for: context)
        let opacity = action.standardButtonBackgroundColorOpacity(for: context)
        let value = action.standardButtonBackgroundColorValue(for: context)
        #expect(color == value.opacity(opacity))
    }

    @Test
    func keyboardActionHasStandardButtonBackgroundColorOpacity() async throws {
        let context = KeyboardContext.preview
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
    func keyboardActionHasStandardButtonBackgroundColorValue() async throws {
        let context = KeyboardContext.preview
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonBackgroundColorValue(for: context)
        }
        var standardResult: Color {
            .keyboardButtonBackground(for: context.colorScheme)
        }
        var standardDarkResult: Color {
            .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardDarkResult)
        #expect(result(for: .primary(.continue)) == .blue)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardDarkResult)
        #expect(result(for: .primary(.continue)) == .blue)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.keyboardCase = .uppercased
        context.colorScheme = .light
        #expect(result(for: .shift(.auto)) == standardResult)
        context.colorScheme = .dark
        #expect(result(for: .shift(.auto)) == .white)
    }

    @Test
    func keyboardActionHasStandardButtonBackgroundColorValueForPressedState() async throws {
        let context = KeyboardContext.preview
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonBackgroundColorValue(for: context, isPressed: true)
        }
        var standardResult: Color {
            .keyboardButtonBackground(for: context.colorScheme)
        }
        var standardDarkResult: Color {
            .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        context.keyboardCase = .lowercased
        context.colorScheme = .light
        #expect(result(for: .character("a")) == standardDarkResult)
        #expect(result(for: .shift(.auto)) == .white)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == standardDarkResult)
        #expect(result(for: .shift(.auto)) == standardResult)
        #expect(result(for: .primary(.continue)) == standardDarkResult)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.keyboardCase = .uppercased
        context.colorScheme = .light
        #expect(result(for: .shift(.auto)) == standardDarkResult)
        context.colorScheme = .dark
        #expect(result(for: .shift(.auto)) == standardDarkResult)
    }

    @Test
    func keyboardActionHasStandardButtonForegroundColor() async throws {
        let context = KeyboardContext.preview
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonForegroundColor(for: context)
        }
        var standardResult: Color {
            .keyboardButtonForeground(for: context.colorScheme)
        }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardResult)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardResult)
        #expect(result(for: .primary(.continue)) == .white)
        context.keyboardCase = .uppercased
        #expect(result(for: .shift(.auto)) == .black)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
    }

    @Test
    func keyboardActionHasStandardButtonForegroundColorForPressedState() async throws {
        let context = KeyboardContext.preview
        func result(for action: KeyboardAction) -> Color {
            action.standardButtonForegroundColor(for: context, isPressed: true)
        }
        var standardResult: Color {
            .keyboardButtonForeground(for: context.colorScheme)
        }
        context.colorScheme = .light
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardResult)
        #expect(result(for: .primary(.continue)) == standardResult)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
        context.colorScheme = .dark
        #expect(result(for: .character("a")) == standardResult)
        #expect(result(for: .shift(.auto)) == standardResult)
        #expect(result(for: .primary(.continue)) == .white)
        #expect(result(for: .none) == .clear)
        #expect(result(for: .characterMargin("")) == .clearInteractable)
    }
}
