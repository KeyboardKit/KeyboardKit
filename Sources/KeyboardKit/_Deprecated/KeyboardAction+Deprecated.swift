//
//  KeyboardAction+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "Use Keyboard.ButtonStyle.standard... instead")
public extension KeyboardAction {

    /// The standard keyboard button style.
    func standardButtonStyle(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Keyboard.ButtonStyle {
        .standard(for: context, action: self, isPressed: isPressed)
    }
}

@available(*, deprecated, message: "Use Keyboard.ButtonStyle.standard... instead")
public extension KeyboardAction {

    func standardButtonBackgroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        .standardKeyboardButtonBackground(for: context, action: self, isPressed: isPressed)
    }

    func standardButtonBackgroundColorOpacity(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Double {
        Color.standardKeyboardButtonBackgroundOpacity(for: context, action: self, isPressed: isPressed)
    }

    func standardButtonBackgroundColorValue(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        Color.standardKeyboardButtonBackgroundValue(for: context, action: self, isPressed: isPressed)
    }

    func standardButtonBorderStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonBorderStyle {
        .standard(for: context, action: self)
    }

    func standardButtonContentInsets(
        for context: KeyboardContext
    ) -> EdgeInsets {
        Keyboard.ButtonStyle.standardContentInsets(for: context, action: self)
    }

    func standardButtonCornerRadius(
        for context: KeyboardContext
    ) -> CGFloat {
        standardButtonLayoutConfiguration(for: context).buttonCornerRadius
    }

    func standardButtonFont(
        for context: KeyboardContext
    ) -> KeyboardFont {
        .standard(for: context, action: self)
    }

    func standardButtonForegroundColor(
        for context: KeyboardContext,
        isPressed: Bool = false
    ) -> Color {
        .standardKeyboardButtonBackground(for: context, action: self, isPressed: isPressed)
    }

    func standardButtonLayoutConfiguration(
        for context: KeyboardContext
    ) -> KeyboardLayout.DeviceConfiguration {
        KeyboardLayout.DeviceConfiguration.standard(for: context)
    }

    func standardButtonShadowStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonShadowStyle {
        .standard(for: context, action: self)
    }
}

@available(*, deprecated, message: "Use KeyboardFont standard functions instead")
extension KeyboardAction {

    func standardButtonFontSize(
        for context: KeyboardContext
    ) -> CGFloat {
        KeyboardFont.standardSize(for: context, action: self)
    }

    func standardButtonFontSizeFixed(
        for context: KeyboardContext
    ) -> CGFloat? {
        KeyboardFont.standardSize(for: self)
    }

    func standardButtonFontSizePad(
        for context: KeyboardContext
    ) -> CGFloat? {
        KeyboardFont.standardSizePad(for: context, action: self)
    }

    func standardButtonFontWeight(
        for context: KeyboardContext
    ) -> KeyboardFont.FontWeight? {
        KeyboardFont.standardWeight(for: context, action: self)
    }
}
