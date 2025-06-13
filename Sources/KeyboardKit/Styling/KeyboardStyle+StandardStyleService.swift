//
//  KeyboardStyle+StandardStyleService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

public extension KeyboardStyleService where Self == KeyboardStyle.StandardStyleService {

    /// Create a standard keyboard service.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    static func standard(
        keyboardContext: KeyboardContext
    ) -> Self {
        KeyboardStyle.StandardStyleService(
            keyboardContext: keyboardContext
        )
    }
}

extension KeyboardStyle {

    /// This class provides a standard way to create dynamic
    /// keyboard styles.
    ///
    /// The service will by default mimic the standard style
    /// of an iOS keyboard on iPhone and iPad.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    open class StandardStyleService: KeyboardStyleService {

        /// Create a standard keyboard style service.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        public init(
            keyboardContext: KeyboardContext
        ) {
            self.keyboardContext = keyboardContext
        }


        /// The keyboard context to use.
        public let keyboardContext: KeyboardContext


        // MARK: - iPad Pro Temp Workaround

        /// Internal shorthand.
        var isIpadPro: Bool { iPadProRenderingModeActive }

        /// Whether or not the style is for an iPad Pro.
        public var iPadProRenderingModeActive: Bool {
            keyboardContext.deviceTypeForKeyboardIsIpadPro
        }


        // MARK: - Keyboard

        /// The background style to apply to the entire keyboard.
        open var backgroundStyle: Keyboard.Background {
            .standard
        }

        /// The foreground color to apply to the entire keyboard.
        open var foregroundColor: Color? {
            nil
        }

        /// The edge insets to apply to the entire keyboard.
        open var keyboardEdgeInsets: EdgeInsets {
            EdgeInsets.standardKeyboardEdgeInsets(for: keyboardContext)
        }

        /// The keyboard layout configuration to use.
        open var keyboardLayoutConfiguration: KeyboardLayout.DeviceConfiguration {
            .standard(for: keyboardContext)
        }


        // MARK: - Buttons

        open var standardButtonContentInsets: EdgeInsets {
            Keyboard.ButtonStyle.standardContentInsets(for: keyboardContext, action: .backspace)
        }

        open func buttonContentInsets(
            for action: KeyboardAction
        ) -> EdgeInsets {
            Keyboard.ButtonStyle.standardContentInsets(for: keyboardContext, action: action)
        }

        open func buttonContentInsets(
            for char: String
        ) -> EdgeInsets {
            Keyboard.ButtonStyle.standardContentInsets(for: keyboardContext, action: .character(char))
        }

        /// The button image to use for a certain action.
        open func buttonImage(
            for action: KeyboardAction
        ) -> Image? {
            action.standardButtonImage(for: keyboardContext)
        }

        /// The content scale factor to use for a certain action.
        open func buttonImageScaleFactor(
            for action: KeyboardAction
        ) -> CGFloat {
            action.standardButtonImageScale(for: keyboardContext)
        }

        /// The button style to use for a certain action.
        open func buttonStyle(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Keyboard.ButtonStyle {
            .init(
                backgroundColor: buttonBackgroundColor(for: action, isPressed: isPressed),
                foregroundColor: buttonForegroundColor(for: action, isPressed: isPressed),
                font: buttonFont(for: action),
                keyboardFont: buttonKeyboardFont(for: action),
                cornerRadius: buttonCornerRadius(for: action),
                border: buttonBorderStyle(for: action),
                shadow: buttonShadowStyle(for: action),
                contentInsets: buttonContentInsets(for: action)
            )

        }

        /// The button text to use for a certain action, if any.
        open func buttonText(
            for action: KeyboardAction
        ) -> String? {
            action.standardButtonText(for: keyboardContext)
        }


        // MARK: - Callouts

        /// The style to override the standard callout style with, if any.
        open var calloutStyle: KeyboardCallout.CalloutStyle? { nil }


        // MARK: - Autocomplete

        /// The style to apply to autocomplete toolbar views.
        open var autocompleteToolbarStyle: Autocomplete.ToolbarStyle { .standard }


        // MARK: - Overridable Button Style Components

        /// The background color to use for a certain action.
        open func buttonBackgroundColor(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Color {
            .standardKeyboardButtonBackground(for: keyboardContext, action: action, isPressed: isPressed)
        }

        /// The background opacity to use for a certain action.
        open func buttonBackgroundOpacity(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Double {
            Color.standardKeyboardButtonBackgroundOpacity(for: keyboardContext, action: action, isPressed: isPressed)
        }

        /// The border style to use for a certain action.
        open func buttonBorderStyle(
            for action: KeyboardAction
        ) -> Keyboard.ButtonBorderStyle {
            Keyboard.ButtonBorderStyle.standard(for: keyboardContext, action: action)
        }

        /// The corner radius to use for a certain action.
        open func buttonCornerRadius(
            for action: KeyboardAction
        ) -> Double {
            Keyboard.ButtonStyle.standardCornerRadius(for: keyboardContext, action: action)
        }

        /// The font to use for a certain action.
        open func buttonFont(
            for action: KeyboardAction
        ) -> Font {
            buttonKeyboardFont(for: action).font
        }

        /// The font size to use for a certain action.
        open func buttonFontSize(
            for action: KeyboardAction
        ) -> CGFloat {
            KeyboardFont.standardSize(for: keyboardContext, action: action)
        }

        /// The font size to override for a certain action.
        func buttonFontSizeActionOverride(
            for action: KeyboardAction
        ) -> CGFloat? {
            KeyboardFont.standardSize(for: action)
        }

        /// The font size to use for a certain keyboard type.
        open func buttonFontSize(
            for type: Keyboard.KeyboardType
        ) -> CGFloat {
            KeyboardFont.standardSize(for: type)
        }

        /// The font weight to use for a certain action.
        open func buttonFontWeight(
            for action: KeyboardAction
        ) -> KeyboardFont.FontWeight? {
            KeyboardFont.standardWeight(for: keyboardContext, action: action)
        }

        /// The foreground color to use for a certain action.
        open func buttonForegroundColor(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Color {
            .standardKeyboardButtonForeground(for: keyboardContext, action: action, isPressed: isPressed)
        }

        /// The keyboard font to use for a certain action.
        open func buttonKeyboardFont(
            for action: KeyboardAction
        ) -> KeyboardFont {
            let font = KeyboardFont.standard(for: keyboardContext, action: action)
            guard let weight = buttonFontWeight(for: action) else { return font }
            return font.weight(weight)
        }

        /// The shadow style to use for a certain action.
        open func buttonShadowStyle(
            for action: KeyboardAction
        ) -> Keyboard.ButtonShadowStyle {
            .standard(for: keyboardContext, action: action)
        }
    }
}


// MARK: - Internal, Testable Extensions

extension KeyboardStyle.StandardStyleService {

    var isProMaxPhone: Bool {
        keyboardContext.screenSize.isEqual(
            to: .iPhoneProMaxScreenPortrait, withTolerance: 10
        )
    }
}
