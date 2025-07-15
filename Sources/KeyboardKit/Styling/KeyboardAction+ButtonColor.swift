//
//  KeyboardAction+ButtonColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-15.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {

    /// The standard keyboard button background color.
    func standardButtonBackgroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorCaps(for: context) { return color }
        let color = standardButtonBackgroundColorValue(for: context, isPressed: isPressed)
        let opacityFunc = standardButtonBackgroundColorOpacity
        let opacity = opacityFunc(context, isPressed)
        return color.opacity(opacity)
    }

    /// The standard keyboard button background opacity.
    func standardButtonBackgroundColorOpacity(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Double {
        if isPrimaryAction { return 1 }
        if context.isSpaceDragGestureActive { return 0.5 }
        if context.hasDarkColorScheme || isPressed { return 1 }
        return 0.95
    }

    /// The standard keyboard button background color in its
    /// raw form, without any opacity applied.
    func standardButtonBackgroundColorValue(
        for context: KeyboardContext,
        isPressed: Bool
    ) -> Color {
        if let color = backgroundColorStatic() { return color }
        if isPressed { return backgroundColorPressed(for: context) }
        return backgroundColorIdle(for: context)
    }

    /// The standard keyboard button style foreground color.
    func standardButtonForegroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = foregroundColorStatic() { return color }
        if isPressed { return foregroundColorPressed(for: context) }
        return foregroundColorIdle(for: context)
    }
}

extension KeyboardAction {

    func backgroundColorCaps(
        for context: KeyboardContext
    ) -> Color? {
        if self == .backspace { return nil }
        guard context.keyboardCase == .capsLocked else { return nil }
        let backspace = KeyboardAction.backspace
        let standard = backspace.standardButtonBackgroundColor
        switch self {
        case .capsLock: return standard(context, true)
        case .shift: return standard(context, !context.isIpadPro)
        default: return nil
        }
    }

    func backgroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) {
            return context.isDark ? .white : .keyboardButtonBackground(for: context.colorScheme)
        }
        if isSystemAction {
            return .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        if isPrimaryAction { return .blue }
        return .keyboardButtonBackground(for: context.colorScheme)
    }

    func backgroundColorPressed(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) {
            return .keyboardDarkButtonBackground(for: context.colorScheme)
        }
        if isSystemAction {
            return context.isDark ? .keyboardButtonBackground(for: context.colorScheme) : .white
        }
        if isPrimaryAction {
            return context.isDark ? .keyboardDarkButtonBackground(for: context.colorScheme) : .white
        }
        return .keyboardDarkButtonBackground(for: context.colorScheme)
    }

    func backgroundColorStatic() -> Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        case .emoji: .clearInteractable
        default: nil
        }
    }

    func foregroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) && context.isDark { return .black }
        if isSystemAction { return .keyboardButtonForeground(for: context.colorScheme) }
        if isPrimaryAction { return .white }
        return .keyboardButtonForeground(for: context.colorScheme)
    }

    func foregroundColorPressed(
        for context: KeyboardContext
    ) -> Color {
        let standard = Color.keyboardButtonForeground(for: context.colorScheme)
        if isPrimaryAction { return context.isDark ? .white : standard }
        return standard
    }

    func foregroundColorStatic() -> Color? {
        switch self {
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
    var isIpadPro: Bool { deviceTypeForKeyboardIsIpadPro }
}
