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

    /// Create a ``KeyboardStyle/StandardStyleService`` instance.
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
        
        static var iPadProRenderingModeActive = false
        
        /// Whether or not the style is for an iPad Pro.
        public var iPadProRenderingModeActive: Bool {
            Self.iPadProRenderingModeActive
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
            switch keyboardContext.deviceTypeForKeyboard {
            case .pad: .init(bottom: 4)
            case .phone: isProMaxPhone ? .zero : .init(bottom: -2)
            default: .zero
            }
        }
        
        /// The keyboard layout configuration to use.
        open var keyboardLayoutConfiguration: KeyboardLayout.Configuration {
            .standard(for: keyboardContext)
        }
        
        
        // MARK: - Buttons
        
        open var standardButtonContentInsets: EdgeInsets {
            .init(all: iPadProRenderingModeActive ? 6 : 3)
        }
        
        open func buttonContentInsets(
            for action: KeyboardAction
        ) -> EdgeInsets {
            switch action {
            case .character(let char): buttonContentInsets(for: char)
            case .characterMargin, .none: .init(all: 0)
            default: standardButtonContentInsets
            }
        }
        
        open func buttonContentInsets(
            for char: String
        ) -> EdgeInsets {
            var insets = standardButtonContentInsets
            switch char {
            case "[", "]", "(", ")", "{", "}": insets.bottom = 6
            case "<", ">": insets.bottom = 4
            default: break
            }
            return insets
        }
        
        /// The button image to use for a certain action.
        open func buttonImage(
            for action: KeyboardAction
        ) -> Image? {
            if let image = buttonImagePadOverride(for: action) { return image }
            return action.standardButtonImage(for: keyboardContext)
        }
        
        /// The content scale factor to use for a certain action.
        open func buttonImageScaleFactor(
            for action: KeyboardAction
        ) -> CGFloat {
            switch keyboardContext.deviceTypeForKeyboard {
            case .pad: 1.2
            default: 1
            }
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
                shadow: buttonShadowStyle(for: action)
            )
        }
        
        /// The button text to use for a certain action, if any.
        open func buttonText(
            for action: KeyboardAction
        ) -> String? {
            if let override = buttonTextPadOverride(for: action) { return override }
            return action.standardButtonText(for: keyboardContext)
        }
        
        
        // MARK: - Callouts
        
        /// The callout style to override the standard style with, if any.
        open var calloutStyle: KeyboardCallout.CalloutStyle? { nil }
        
        
        // MARK: - Autocomplete
        
        /// The style to apply to ``Autocomplete/Toolbar`` views.
        public var autocompleteToolbarStyle: Autocomplete.ToolbarStyle {
            .standard
        }
        
        
        // MARK: - Overridable Button Style Components
        
        /// The background color to use for a certain action.
        open func buttonBackgroundColor(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Color {
            if iPadProRenderingModeActive, let color = buttonColorPadProOverride(for: action) {
                return color
            }
            let context = keyboardContext
            let color = action.buttonBackgroundColor(for: context, isPressed: isPressed)
            let opacity = buttonBackgroundOpacity(for: action, isPressed: isPressed)
            return color.opacity(opacity)
        }
        
        /// The background opacity to use for a certain action.
        open func buttonBackgroundOpacity(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Double {
            let context = keyboardContext
            if context.isSpaceDragGestureActive { return 0.5 }
            if context.hasDarkColorScheme || isPressed { return 1 }
            return 0.95
        }
        
        /// The border style to use for a certain action.
        open func buttonBorderStyle(
            for action: KeyboardAction
        ) -> Keyboard.ButtonBorderStyle {
            switch action {
            case .emoji, .none: .noBorder
            default: .standard
            }
        }
        
        /// The corner radius to use for a certain action.
        open func buttonCornerRadius(
            for action: KeyboardAction
        ) -> CGFloat {
            keyboardLayoutConfiguration.buttonCornerRadius
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
            if let override = buttonFontSizePadOverride(for: action) { return override }
            if buttonImage(for: action) != nil { return 20 }
            if let override = buttonFontSizeActionOverride(for: action) { return override }
            let text = buttonText(for: action) ?? ""
            if action.isInputAction && text.isLowercasedWithUppercaseVariant { return 26 }
            if action.isSystemAction || action.isPrimaryAction { return 16 }
            return 23
        }

        /// The font size to override for a certain action.
        func buttonFontSizeActionOverride(
            for action: KeyboardAction
        ) -> CGFloat? {
            switch action {
            case .text: 16
            case .keyboardType(let type): buttonFontSize(for: type)
            case .space: 16
            default: nil
            }
        }
        
        /// The font size to use for a certain keyboard type.
        open func buttonFontSize(
            for keyboardType: Keyboard.KeyboardType
        ) -> CGFloat {
            switch keyboardType {
            case .alphabetic: 15
            case .numeric: 16
            case .symbolic: 14
            default: 14
            }
        }
        
        /// The font weight to use for a certain action.
        open func buttonFontWeight(
            for action: KeyboardAction
        ) -> KeyboardFont.FontWeight? {
            switch action {
            case .backspace: return .light
            case .character(let char): return char.isLowercasedWithUppercaseVariant ? .light : nil
            default: return buttonImage(for: action) != nil ? .light : nil
            }
        }
        
        /// The foreground color to use for a certain action.
        open func buttonForegroundColor(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Color {
            action.buttonForegroundColor(for: keyboardContext, isPressed: isPressed)
        }

        /// The keyboard font to use for a certain action.
        open func buttonKeyboardFont(
            for action: KeyboardAction
        ) -> KeyboardFont {
            let size = buttonFontSize(for: action)
            let font = KeyboardFont.system(size: size)
            guard let weight = buttonFontWeight(for: action) else { return font }
            return font.weight(weight)
        }

        /// The shadow style to use for a certain action.
        open func buttonShadowStyle(
            for action: KeyboardAction
        ) -> Keyboard.ButtonShadowStyle {
            if keyboardContext.isSpaceDragGestureActive { return .noShadow }
            switch action {
            case .characterMargin: return .noShadow
            case .emoji: return .noShadow
            case .none: return .noShadow
            default: return .standard
            }
        }
    }
}


// MARK: - Internal, Testable Extensions

extension KeyboardStyle.StandardStyleService {

    var isGregorianAlpha: Bool {
        keyboardType == .alphabetic && locale == .georgian
    }
    
    var isProMaxPhone: Bool {
        screenSize.isEqual(to: .iPhoneProMaxScreenPortrait, withTolerance: 10)
    }
    
    var keyboardType: Keyboard.KeyboardType {
        keyboardContext.keyboardType
    }
    
    var locale: Locale {
        keyboardContext.locale
    }
    
    var screenSize: CGSize {
        keyboardContext.screenSize
    }
}

extension KeyboardAction {

    func isUpperShift(for context: KeyboardContext) -> Bool {
        isShiftAction && context.keyboardCase.isUppercasedOrCapslocked
    }

    var buttonBackgroundColorForAllStates: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        case .emoji: .clearInteractable
        default: nil
        }
    }

    func buttonBackgroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonBackgroundColorForAllStates { return color }
        return isPressed ?
            buttonBackgroundColorForPressedState(for: context) :
            buttonBackgroundColorForIdleState(for: context)
    }

    func buttonBackgroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isUpperShift(for: context) && context.hasDarkColorScheme { return .white }
        if isUpperShift(for: context) { return .keyboardButtonBackground(for: context.colorScheme) }
        if isSystemAction { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isPrimaryAction { return .blue }
        return .keyboardButtonBackground(for: context.colorScheme)
    }

    func buttonBackgroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isUpperShift(for: context) { return .keyboardDarkButtonBackground(for: context.colorScheme) }
        if isSystemAction { return context.hasDarkColorScheme ? .keyboardButtonBackground(for: context.colorScheme) : .white }
        if isPrimaryAction { return context.hasDarkColorScheme ? .keyboardDarkButtonBackground(for: context.colorScheme) : .white }
        return .keyboardDarkButtonBackground(for: context.colorScheme)
    }

    var buttonForegroundColorForAllStates: Color? {
        switch self {
        case .none: .clear
        case .characterMargin: .clearInteractable
        default: nil
        }
    }

    func buttonForegroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonForegroundColorForAllStates { return color }
        return isPressed ?
            buttonForegroundColorForPressedState(for: context) :
            buttonForegroundColorForIdleState(for: context)
        
    }

    func buttonForegroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isUpperShift(for: context) && context.hasDarkColorScheme { return .black }
        let standard = Color.keyboardButtonForeground(for: context.colorScheme)
        if isSystemAction { return standard }
        if isPrimaryAction { return .white }
        return standard
    }

    func buttonForegroundColorForPressedState(for context: KeyboardContext) -> Color {
        let standard = Color.keyboardButtonForeground(for: context.colorScheme)
        if isSystemAction { return standard }
        if isPrimaryAction { return context.hasDarkColorScheme ? .white : standard }
        return standard
    }
}
