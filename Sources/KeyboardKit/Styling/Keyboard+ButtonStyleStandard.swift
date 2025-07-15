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
        let font = KeyboardFont.standard(for: context, action: action)
        return Keyboard.ButtonStyle(
            backgroundColor: action.standardKeyboardButtonBackground(for: context, isPressed: isPressed),
            foregroundColor: action.standardKeyboardButtonForeground(for: context, isPressed: isPressed),
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

#Preview {

    func preview(
        _ type: Keyboard.ReturnKeyType
    ) -> some View {
        KeyboardView(
            state: {
                let state = Keyboard.State.preview
                state.keyboardContext.returnKeyTypeOverride = type
                return state
            }(),
            services: .preview
        )
    }

    return VStack {
        preview(.return)
        preview(.continue)
    }
}
