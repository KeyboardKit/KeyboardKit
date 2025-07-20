//
//  KeyboardAction+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /// The standard button style.
    ///
    /// You can use individual style builders to calculate a
    /// single values instead of the entire style.
    func standardButtonStyle(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Keyboard.ButtonStyle {
        let font = standardButtonFont(for: context)
        return Keyboard.ButtonStyle(
            backgroundColor: standardButtonBackgroundColor(
                for: context,
                isPressed: isPressed
            ),
            foregroundColor: standardButtonForegroundColor(
                for: context,
                isPressed: isPressed
            ),
            font: font.font,
            keyboardFont: font,
            cornerRadius: standardButtonCornerRadius(for: context),
            border: standardButtonBorderStyle(for: context),
            shadow: standardButtonShadowStyle(for: context)
        )
    }
}

public extension KeyboardAction {

    /// The standard button border style.
    func standardButtonBorderStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonBorderStyle {
        switch self {
        case .emoji, .none: .noBorder
        default: .standard
        }
    }

    /// The standard button style content insets.
    func standardButtonContentInsets(
        for context: KeyboardContext
    ) -> EdgeInsets {
        switch self {
        case .character(let char): Self.standardButtonContentInsets(for: context, character: char)
        case .characterMargin, .none: .init(all: 0)
        case .text(let text): Self.standardButtonContentInsets(for: context, character: text)
        default: .init(all: context.deviceTypeForKeyboardIsIpadPro ? 6 : 3)
        }
    }

    /// The standard button style corner radius.
    func standardButtonCornerRadius(
        for context: KeyboardContext
    ) -> CGFloat {
        let config = standardButtonLayoutConfiguration(for: context)
        return config.buttonCornerRadius
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

    static func standardButtonContentInsets(
        for context: KeyboardContext,
        character: String
    ) -> EdgeInsets {
        let backspace = KeyboardAction.backspace
        var standard = backspace.standardButtonContentInsets(for: context)
        switch character {
        case "[", "]", "(", ")", "{", "}": standard.bottom = 6
        case "<", ">": standard.bottom = 4
        default: break
        }
        return standard
    }
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
    .background(Color.keyboardBackground)
}
