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
        context: KeyboardContext,
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        Keyboard.ButtonStyle(
            backgroundColor: action.standardButtonBackgroundColor(
                for: context,
                isPressed: isPressed
            ),
            foregroundColor: action.standardButtonForegroundColor(
                for: context,
                isPressed: isPressed
            ),
            // font: <#T##Font?#>,
            // keyboardFont: <#T##KeyboardFont?#>,
            cornerRadius: action.standardButtonCornerRadius(for: context),
            border: action.standardButtonBorderStyle(for: context),
            shadow: action.standardButtonShadowStyle(for: context)
        )
    }
}

public extension Keyboard.ButtonStyleBuilderParams {

    /// The standard keyboard button style to use.
    func standardButtonStyle(
        for context: KeyboardContext,
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        .standard(for: action, context: context, isPressed: isPressed)
    }
}
