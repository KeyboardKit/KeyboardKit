//
//  KeyboardAction+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// The standard button background color.
    func standardButtonBackgroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorCaps(for: context) { return color }
        let color = standardButtonBackgroundColorValue(for: context, isPressed: isPressed)
        let opacity = standardButtonBackgroundColorOpacity(for: context, isPressed: isPressed)
        return color.opacity(opacity)
    }

    /// The standard button border style.
    func standardButtonBorderStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonBorderStyle {
        switch self {
        case .emoji, .none: .noBorder
        default: .standard
        }
    }

    /// The standard button corner radius.
    func standardButtonCornerRadius(
        for context: KeyboardContext
    ) -> CGFloat {
        let config = standardButtonLayoutConfiguration(for: context)
        return config.buttonCornerRadius
    }

    /// The standard button foreground color.
    func standardButtonForegroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = foregroundColorStatic { return color }
        if isPressed { return foregroundColorPressed(for: context) }
        return foregroundColorIdle(for: context)
    }

    /// The standard button layout configuration.
    func standardButtonLayoutConfiguration(
        for context: KeyboardContext
    ) -> KeyboardLayout.DeviceConfiguration {
        .standard(for: context)
    }

    /// The standard button shadow style.
    func standardButtonShadowStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonShadowStyle {
        switch self {
        case .characterMargin: .noShadow
        case .emoji: .noShadow
        case .none: .noShadow
        default: context.isSpaceDragGestureActive ? .noShadow : .standard
        }
    }
}

extension KeyboardAction {

    func isUpperCasedShift(
        for context: KeyboardContext
    ) -> Bool {
        isShiftAction && context.keyboardCase.isUppercasedOrCapslocked
    }

    /// Internal bcs it's used by the standard style service
    /// and unit tests.
    func standardButtonBackgroundColorOpacity(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Double {
        if isPrimaryAction { return 1 }
        if context.isSpaceDragGestureActive { return 0.5 }
        if context.hasDarkColorScheme || isPressed { return 1 }
        return 0.95
    }

    /// Internal bcs it's used by the standard style service
    /// and unit tests.
    func standardButtonBackgroundColorValue(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorStatic { return color }
        if isPressed { return backgroundColorPressed(for: context) }
        return backgroundColorIdle(for: context)
    }

    /// Internal bcs it's used by the standard style service.
    func standardButtonFontSize(
        for context: KeyboardContext
    ) -> CGFloat? {
        if let size = standardButtonFontSizePadOverride(for: context) { return size }
        if hasStandardButtonImage(for: context) { return 20 }
        if let size = standardButtonFontSizeFixed(for: context) { return size }
        return nil
    }

    /// Internal bcs it's used by the standard style service.
    func standardButtonFontSizeFixed(
        for context: KeyboardContext
    ) -> CGFloat? {
        switch self {
        case .keyboardType(let type): type.standardButtonFontSize
        case .space: 16
        case .text: 16
        default: nil
        }
    }

    /// Internal bcs it's used by the standard style service.
    func standardButtonFontSizePadOverride(
        for context: KeyboardContext
    ) -> CGFloat? {
        nil
    }

    /// Internal bcs it's used by the standard style service.
    func standardButtonFontWeight(
        for context: KeyboardContext
    ) -> KeyboardFont.FontWeight? {
        switch self {
        case .backspace: .light
        case .character(let char): char.isLowercasedWithUppercaseVariant ? .light : nil
        default: hasStandardButtonImage(for: context) ? .light : nil
        }
    }
}

private extension KeyboardAction {

    var backgroundColorStatic: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        case .emoji: .clearInteractable
        default: nil
        }
    }

    func backgroundColorCaps(
        for context: KeyboardContext
    ) -> Color? {
        guard context.keyboardCase == .capsLocked else { return nil }
        let color = KeyboardAction.backspace.standardButtonBackgroundColor
        switch self {
        case .capsLock: return color(context, true)
        case .shift: return color(context, false)
        default: return nil
        }
    }

    func backgroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) { return context.isDark ? .white : .keyboardButtonBackground(for: context.colorScheme) }
        if isSystemAction { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isPrimaryAction { return .blue }
        return .keyboardButtonBackground(for: context.colorScheme)
    }

    func backgroundColorPressed(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isSystemAction { return context.isDark ? .keyboardButtonBackground(for: context.colorScheme) : .white }
        if isPrimaryAction { return context.isDark ? .keyboardDarkButtonBackground(for: context.colorScheme) : .white }
        return .keyboardDarkButtonBackground(for: context.colorScheme)
    }

    var foregroundColorStatic: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        default: nil
        }
    }

    func foregroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) && context.isDark { return .black }
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
}

private extension KeyboardContext {

    var isDark: Bool { hasDarkColorScheme }
}

extension Keyboard.KeyboardType {

    /// Internal bcs it's used by the standard style service.
    var standardButtonFontSize: CGFloat {
        switch self {
        case .alphabetic: 15
        case .numeric: 16
        case .symbolic: 14
        default: 14
        }
    }
}
