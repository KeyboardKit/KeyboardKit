//
//  KeyboardAction+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// The standard keyboard button style.
    func standardButtonStyle(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Keyboard.ButtonStyle {
        let font = standardButtonFont(for: context)
        return Keyboard.ButtonStyle(
            backgroundColor: standardButtonBackgroundColor(for: context, isPressed: isPressed),
            foregroundColor: standardButtonForegroundColor(for: context, isPressed: isPressed),
            font: font.font,
            keyboardFont: font,
            cornerRadius: standardButtonCornerRadius(for: context),
            border: standardButtonBorderStyle(for: context),
            shadow: standardButtonShadowStyle(for: context)
        )
    }
}

public extension KeyboardAction {

    /// The standard keyboard button background color.
    func standardButtonBackgroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorCaps(for: context) { return color }
        let color = standardButtonBackgroundColorValue(for: context, isPressed: isPressed)
        let opacity = standardButtonBackgroundColorOpacity(for: context, isPressed: isPressed)
        return color.opacity(opacity)
    }

    /// The standard keyboard button border style.
    func standardButtonBorderStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonBorderStyle {
        switch self {
        case .emoji, .none: .noBorder
        default: .standard
        }
    }

    /// The standard keyboard button content insets.
    func standardButtonContentInsets(
        for context: KeyboardContext
    ) -> EdgeInsets {
        switch self {
        case .character(let char): standardButtonContentInsets(for: context, char)
        case .characterMargin, .none: .init(all: 0)
        default: .init(all: context.deviceTypeForKeyboardIsIpadPro ? 6 : 3)
        }
    }

    /// The standard keyboard button corner radius.
    func standardButtonCornerRadius(
        for context: KeyboardContext
    ) -> CGFloat {
        let config = standardButtonLayoutConfiguration(for: context)
        return config.buttonCornerRadius
    }

    /// The standard keyboard button font.
    func standardButtonFont(
        for context: KeyboardContext
    ) -> KeyboardFont {
        let size = standardButtonFontSize(for: context)
        let weight = standardButtonFontWeight(for: context)
        let font = KeyboardFont.system(size: size)
        if let weight { return font.weight(weight) }
        return font
    }

    /// The standard keyboard button foreground color.
    func standardButtonForegroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = foregroundColorStatic { return color }
        if isPressed { return foregroundColorPressed(for: context) }
        return foregroundColorIdle(for: context)
    }

    /// The standard keyboard button layout configuration.
    func standardButtonLayoutConfiguration(
        for context: KeyboardContext
    ) -> KeyboardLayout.DeviceConfiguration {
        .standard(for: context)
    }

    /// The standard keyboard button shadow style.
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

    func standardButtonBackgroundColorOpacity(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Double {
        if isPrimaryAction { return 1 }
        if context.isSpaceDragGestureActive { return 0.5 }
        if context.hasDarkColorScheme || isPressed { return 1 }
        return 0.95
    }

    func standardButtonBackgroundColorValue(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = backgroundColorStatic { return color }
        if isPressed { return backgroundColorPressed(for: context) }
        return backgroundColorIdle(for: context)
    }

    func standardButtonContentInsets(
        for context: KeyboardContext,
        _ character: String
    ) -> EdgeInsets {
        var standard = KeyboardAction.backspace.standardButtonContentInsets(for: context)
        switch character {
        case "[", "]", "(", ")", "{", "}": standard.bottom = 6
        case "<", ">": standard.bottom = 4
        default: break
        }
        return standard
    }

    func standardButtonFontSize(
        for context: KeyboardContext
    ) -> CGFloat {
        if let size = standardButtonFontSizePad(for: context) {
            return size
        }
        if hasStandardButtonImage(for: context) { return 20 }
        let fixed = standardButtonFontSizeFixed(for: context)
        if let fixed = fixed { return fixed }
        let text = standardButtonText(for: context) ?? ""
        if isPrimaryAction && isSystemAction { return 16 }
        if isInputAction && text.isLowercasedWithUppercaseVariant { return 26 }
        return 23
    }

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

    func standardButtonFontSizePad(
        for context: KeyboardContext
    ) -> CGFloat? {
        if useIpadProText(for: context) {
            return context.interfaceOrientation == .portrait ? 16 : 20
        }
        guard context.deviceTypeForKeyboard == .pad else { return nil }
        guard context.interfaceOrientation.isLandscape else { return nil }
        if isKeyboardTypeAction(.alphabetic) { return 22 }
        if isKeyboardTypeAction(.numeric) { return 22 }
        if isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }

    func standardButtonFontWeight(
        for context: KeyboardContext
    ) -> KeyboardFont.FontWeight? {
        switch self {
        case .backspace: .light
        case .character(let char): char.isLowercasedWithUppercaseVariant ? .light : nil
        default: hasStandardButtonImage(for: context) ? .light : nil
        }
    }

    func useIpadProText(
        for context: KeyboardContext
    ) -> Bool {
        switch self {
        case let .keyboardType(type): useIpadProText(for: context, type)
        default: standardButtonTextIpadPro(for: context) != nil
        }
    }

    func useIpadProText(
        for context: KeyboardContext,
        _ type: Keyboard.KeyboardType
    ) -> Bool {
        guard context.deviceTypeForKeyboardIsIpadPro else { return false }
        switch type {
        case .alphabetic, .numeric, .symbolic: return true
        default: return false
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
