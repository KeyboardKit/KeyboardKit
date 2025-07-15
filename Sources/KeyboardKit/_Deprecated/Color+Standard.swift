//
//  Color+Standard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-06-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "Use KeyboardAction extensions instead.")
public extension Color {

    /// The standard keyboard button background color.
    static func standardKeyboardButtonBackground(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Color {
        action.standardKeyboardButtonBackground(
            for: context,
            isPressed: isPressed
        )
    }

    /// The standard keyboard button background opacity.
    static func standardKeyboardButtonBackgroundOpacity(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Double {
        action.standardKeyboardButtonBackgroundOpacity(
            for: context,
            isPressed: isPressed
        )
    }

    /// The standard keyboard button background color in its
    /// raw form, without any opacity applied.
    static func standardKeyboardButtonBackgroundValue(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool
    ) -> Color {
        action.standardKeyboardButtonBackgroundValue(
            for: context,
            isPressed: isPressed
        )
    }

    /// The standard keyboard button style foreground color.
    static func standardKeyboardButtonForeground(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Color {
        action.standardKeyboardButtonForeground(
            for: context,
            isPressed: isPressed
        )
    }
}
