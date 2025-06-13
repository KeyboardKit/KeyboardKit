//
//  Color+Standard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-06-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    /// The standard keyboard button background color.
    static func standardKeyboardButtonBackground(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorCaps(for: context, action: action) { return color }
        let color = standardKeyboardButtonBackgroundValue(for: context, action: action, isPressed: isPressed)
        let opacityFunc = standardKeyboardButtonBackgroundOpacity
        let opacity = opacityFunc(context, action, isPressed)
        return color.opacity(opacity)
    }

    /// The standard keyboard button background opacity.
    static func standardKeyboardButtonBackgroundOpacity(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Double {
        if action.isPrimaryAction { return 1 }
        if context.isSpaceDragGestureActive { return 0.5 }
        if context.hasDarkColorScheme || isPressed { return 1 }
        return 0.95
    }

    /// The standard keyboard button background color in its
    /// raw form, without any opacity applied.
    static func standardKeyboardButtonBackgroundValue(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool
    ) -> Color {
        if let color = backgroundColorStatic(for: action) { return color }
        if isPressed { return backgroundColorPressed(for: context, action: action) }
        return backgroundColorIdle(for: context, action: action)
    }

    /// The standard keyboard button style foreground color.
    static func standardKeyboardButtonForeground(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Color {
        if let color = foregroundColorStatic(for: action) { return color }
        if isPressed { return foregroundColorPressed(for: context, action: action) }
        return foregroundColorIdle(for: context, action: action)
    }
}

extension Color {

    static func backgroundColorCaps(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Color? {
        if action == .backspace { return nil }
        guard context.keyboardCase == .capsLocked else { return nil }
        let standard = standardKeyboardButtonBackground
        switch action {
        case .capsLock: return standard(context, .backspace, true)
        case .shift: return standard(context, .backspace, false)
        default: return nil
        }
    }

    static func backgroundColorIdle(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Color {
        if action.isUpperCasedShift(for: context) {
            return context.isDark ? .white : .keyboardButtonBackground(for: context.colorScheme)
        }
        if action.isSystemAction {
            return .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        if action.isPrimaryAction { return .blue }
        return .keyboardButtonBackground(for: context.colorScheme)
    }

    static func backgroundColorPressed(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Color {
        if action.isUpperCasedShift(for: context) {
            return .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        if action.isSystemAction {
            return context.isDark ? .keyboardButtonBackground(for: context.colorScheme) : .white
        }
        if action.isPrimaryAction {
            return context.isDark ? .keyboardDarkButtonBackground(for: context.colorScheme) : .white
        }
        return .keyboardDarkButtonBackground(for: context.colorScheme)
    }

    static func backgroundColorStatic(
        for action: KeyboardAction
    ) -> Color? {
        switch action {
        case .none: .clear
        case .characterMargin: .clearInteractable
        case .emoji: .clearInteractable
        default: nil
        }
    }

    static func foregroundColorIdle(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Color {
        if action.isUpperCasedShift(for: context) && context.isDark { return .black }
        if action.isSystemAction { return .keyboardButtonForeground(for: context.colorScheme) }
        if action.isPrimaryAction { return .white }
        return .keyboardButtonForeground(for: context.colorScheme)
    }

    static func foregroundColorPressed(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Color {
        let standard = Color.keyboardButtonForeground(for: context.colorScheme)
        if action.isPrimaryAction { return context.isDark ? .white : standard }
        return standard
    }

    static func foregroundColorStatic(
        for action: KeyboardAction
    ) -> Color? {
        switch action {
        case .none: .clear
        case .characterMargin: .clearInteractable
        default: nil
        }
    }
}

private extension KeyboardAction {

    func isUpperCasedShift(
        for context: KeyboardContext
    ) -> Bool {
        isShiftAction && context.keyboardCase.isUppercasedOrCapslocked
    }
}

private extension KeyboardContext {

    var isDark: Bool { hasDarkColorScheme }
}
