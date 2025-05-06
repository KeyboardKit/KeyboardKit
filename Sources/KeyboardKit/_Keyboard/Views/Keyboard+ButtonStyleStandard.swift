//
//  Keyboard+ButtonStyleStandard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard.ButtonStyle {

    /// The standard keyboard button style to use.
    static func standard(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        switch context.deviceTypeForKeyboard {
        case .pad: standardPad(for: action, context: context)
        default: standardPhone(for: action, context: context)
        }
    }
}

public extension Keyboard.ButtonStyleBuilderParams {

    /// The standard keyboard button style to use.
    func standardButtonStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        .standard(for: action, context: context)
    }
}

public extension Keyboard.ButtonStyle {

    /// A standard iPhone keyboard button style.
    static func standardPhone(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        .init(
//            background: <#T##Keyboard.Background?#>,
//            backgroundColor: <#T##Color?#>,
//            foregroundColor: <#T##Color?#>,
//            font: <#T##Font?#>,
//            keyboardFont: <#T##KeyboardFont?#>,
//            cornerRadius: <#T##CGFloat?#>,
//            border: <#T##BorderStyle?#>,
//            shadow: <#T##ShadowStyle?#>,
//            pressedOverlayColor: <#T##Color?#>
        )
    }

    /// A standard iPad keyboard button style to use.
    static func standardPad(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        fatalError()
//        .init(
//            background: <#T##Keyboard.Background?#>,
//            backgroundColor: <#T##Color?#>,
//            foregroundColor: <#T##Color?#>,
//            font: <#T##Font?#>,
//            keyboardFont: <#T##KeyboardFont?#>,
//            cornerRadius: <#T##CGFloat?#>,
//            border: <#T##BorderStyle?#>,
//            shadow: <#T##ShadowStyle?#>,
//            pressedOverlayColor: <#T##Color?#>
//        )
    }
}

extension KeyboardAction {

    func isUpperCasedShift(
        for context: KeyboardContext
    ) -> Bool {
        isShiftAction && context.keyboardCase.isUppercasedOrCapslocked
    }
}

extension KeyboardAction {

    /// The standard button background color.
    func standardButtonBackgroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = standardButtonBackgroundColorCapsLock(for: context) { return color }
        let color = standardButtonBackgroundColorValue(for: context, isPressed: isPressed)
        let opacity = standardButtonBackgroundColorOpacity(for: context, isPressed: isPressed)
        return color.opacity(opacity)
    }

    /// The standard button background color opacity.
    func standardButtonBackgroundColorOpacity(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Double {
        if isPrimaryAction { return 1 }
        if context.isSpaceDragGestureActive { return 0.5 }
        if context.hasDarkColorScheme || isPressed { return 1 }
        return 0.95
    }

    /// The standard button background color value.
    func standardButtonBackgroundColorValue(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = standardButtonBackgroundColorStatic { return color }
        if isPressed { return standardButtonBackgroundColorPressed(for: context) }
        return standardButtonBackgroundColorIdle(for: context)
    }

    /// The standard button foreground color.
    func standardButtonForegroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        if let color = standardButtonForegroundColorStatic { return color }
        if isPressed { return standardButtonForegroundColorPressed(for: context) }
        return standardButtonForegroundColorIdle(for: context)
    }
}

private extension KeyboardAction {

    var standardButtonBackgroundColorStatic: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        case .emoji: .clearInteractable
        default: nil
        }
    }

    var standardButtonForegroundColorStatic: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        default: nil
        }
    }

    func standardButtonBackgroundColorCapsLock(
        for context: KeyboardContext
    ) -> Color? {
        guard context.keyboardCase == .capsLocked else { return nil }
        let action = KeyboardAction.backspace
        switch self {
        case .capsLock: return action.standardButtonBackgroundColor(for: context, isPressed: true)
        case .shift: return action.standardButtonBackgroundColor(for: context, isPressed: false)
        default: return nil
        }
    }

    func standardButtonBackgroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) { return context.isDark ? .white : .keyboardButtonBackground(for: context.colorScheme) }
        if isSystemAction { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isPrimaryAction { return .blue }
        return .keyboardButtonBackground(for: context.colorScheme)
    }

    func standardButtonBackgroundColorPressed(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isSystemAction { return context.isDark ? .keyboardButtonBackground(for: context.colorScheme) : .white }
        if isPrimaryAction { return context.isDark ? .keyboardDarkButtonBackground(for: context.colorScheme) : .white }
        return .keyboardDarkButtonBackground(for: context.colorScheme)
    }

    func standardButtonForegroundColorIdle(
        for context: KeyboardContext
    ) -> Color {
        if isUpperCasedShift(for: context) && context.isDark { return .black }
        if isPrimaryAction { return .white }
        return .keyboardButtonForeground(for: context.colorScheme)
    }

    func standardButtonForegroundColorPressed(
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
