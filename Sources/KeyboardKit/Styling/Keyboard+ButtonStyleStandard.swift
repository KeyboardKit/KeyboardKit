//
//  Keyboard+ButtonStyleStandard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-06-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard.ButtonStyle {

    /// The standard keyboard button style.
    ///
    /// You can use the various standard value builders when
    /// you just want to calculate a single value instead of
    /// the entire style.
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Keyboard.ButtonStyle {
        let font = standardFont(for: context, action: action)
        return Keyboard.ButtonStyle(
            backgroundColor: .standardKeyboardButtonBackground(for: context, action: action, isPressed: isPressed),
            foregroundColor: .standardKeyboardButtonForeground(for: context, action: action, isPressed: isPressed),
            font: font.font,
            keyboardFont: font,
            cornerRadius: standardCornerRadius(for: context, action: action),
            border: .standard(for: context, action: action),
            shadow: .standard(for: context, action: action)
        )
    }
}

public extension Keyboard.ButtonStyle {

    /// The standard keyboard button style content insets.
    static func standardContentInsets(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> EdgeInsets {
        switch action {
        case .character(let char): contentInsets(for: context, character: char)
        case .characterMargin, .none: .init(all: 0)
        default: .init(all: context.deviceTypeForKeyboardIsIpadPro ? 6 : 3)
        }
    }

    /// The standard keyboard button style corner radius.
    static func standardCornerRadius(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat {
        KeyboardLayout.DeviceConfiguration.standard(for: context).buttonCornerRadius
    }

    /// The standard keyboard button style font.
    static func standardFont(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont {
        let size = standardFontSize(for: context, action: action)
        let weight = standardFontWeight(for: context, action: action)
        let font = KeyboardFont.system(size: size)
        if let weight { return font.weight(weight) }
        return font
    }

    /// The standard keyboard button style font size.
    static func standardFontSize(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat {
        if let size = fontSizePad(for: context, action: action) {
            return size
        }
        if action.hasStandardButtonImage(for: context) { return 20 }
        if let fixed = fontSizeFixed(for: context, action: action) { return fixed }
        let text = action.standardButtonText(for: context) ?? ""
        if action.isPrimaryAction && action.isSystemAction { return 16 }
        if action.isInputAction && text.isLowercasedWithUppercaseVariant { return 26 }
        return 23
    }

    /// The standard keyboard button style font weight.
    static func standardFontWeight(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont.FontWeight? {
        switch action {
        case .backspace: .light
        case .character(let char): char.isLowercasedWithUppercaseVariant ? .light : nil
        default: action.hasStandardButtonImage(for: context) ? .light : nil
        }
    }
}

public extension Keyboard.ButtonBorderStyle {

    /// The standard keyboard button border style.
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Self {
        switch action {
        case .emoji, .none: .noBorder
        default: .standard
        }
    }
}

public extension Keyboard.ButtonShadowStyle {

    /// The standard keyboard button style shadow style.
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Keyboard.ButtonShadowStyle {
        switch action {
        case .characterMargin: .noShadow
        case .emoji: .noShadow
        case .none: .noShadow
        default: context.isSpaceDragGestureActive ? .noShadow : .standard
        }
    }
}

extension Keyboard.ButtonStyle {

    static func contentInsets(
        for context: KeyboardContext,
        character: String
    ) -> EdgeInsets {
        var standard = standardContentInsets(for: context, action: .backspace)
        switch character {
        case "[", "]", "(", ")", "{", "}": standard.bottom = 6
        case "<", ">": standard.bottom = 4
        default: break
        }
        return standard
    }
}

extension Keyboard.ButtonStyle {

    static func fontSizeFixed(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat? {
        switch action {
        case .keyboardType(let type): type.standardButtonFontSize
        case .space: 16
        case .text: 16
        default: nil
        }
    }

    static func fontSizePad(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat? {
        if useIpadProText(for: context, action: action) {
            return context.interfaceOrientation == .portrait ? 16 : 20
        }
        guard context.deviceTypeForKeyboard == .pad else { return nil }
        guard context.interfaceOrientation.isLandscape else { return nil }
        if action.isKeyboardTypeAction(.alphabetic) { return 22 }
        if action.isKeyboardTypeAction(.numeric) { return 22 }
        if action.isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }

    static func useIpadProText(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Bool {
        switch action {
        case let .keyboardType(type): useIpadProText(for: context, type)
        default: action.standardButtonTextIpadPro(for: context) != nil
        }
    }

    static func useIpadProText(
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
