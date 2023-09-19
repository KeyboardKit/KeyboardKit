//
//  StandardKeyboardStyleProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

/**
 This standard style provider returns styles that by default
 mimic the look of a native iOS keyboard.

 You can inherit this class and override any open properties
 and functions to customize the various styles.
 
 For instance, to change the background color of every input
 key, you can do this:

 ```swift
 class CustomKeyboardStyleProvider: StandardKeyboardStyleProvider {

     override func buttonStyle(
         for action: KeyboardAction,
         isPressed: Bool
     ) -> KeyboardStyle.Button {
         let style = super.buttonStyle(for: action, isPressed: isPressed)
         if !action.isInputAction { return style }
         style.backgroundColor = .red
         return style
     }
 }
 ```

 All buttons will be affected if you only return a new style.
 Sometimes that is what you want, but most often perhaps not.
 */
open class StandardKeyboardStyleProvider: KeyboardStyleProvider {

    /**
     Create a standard keyboard style provider instance.

     - Parameters:
       - keyboardContext: The keyboard context to use.
     */
    public init(keyboardContext: KeyboardContext) {
        self.keyboardContext = keyboardContext
    }


    /// The keyboard context to use.
    public let keyboardContext: KeyboardContext


    // MARK: - Keyboard

    /// The background style to apply to the entire keyboard.
    open var backgroundStyle: KeyboardStyle.Background {
        .standard
    }

    /// The foreground color to apply to the entire keyboard.
    open var foregroundColor: Color? { nil }

    /// The edge insets to apply to the entire keyboard.
    open var keyboardEdgeInsets: EdgeInsets {
        switch keyboardContext.deviceType {
        case .pad: return .init(top: 0, leading: 0, bottom: 4, trailing: 0)
        case .phone:
            if keyboardContext.screenSize.isEqual(to: .iPhoneProMaxScreenPortrait, withTolerance: 10) {
                return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            } else {
                return .init(top: 0, leading: 0, bottom: -2, trailing: 0)
            }
        default: return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }

    /// The keyboard layout configuration to use.
    open var keyboardLayoutConfiguration: KeyboardLayoutConfiguration {
        .standard(for: keyboardContext)
    }


    // MARK: - Buttons
    
    /// The button content bottom margin for an action.
    open func buttonContentBottomMargin(for action: KeyboardAction) -> CGFloat {
        switch action {
        case .character(let char): return buttonContentBottomMargin(for: char)
        default: return 0
        }
    }
    
    /// The button content bottom margin for a character.
    open func buttonContentBottomMargin(for char: String) -> CGFloat {
        switch char {
        case "-", "/", ":", ";", "@": return 3
        case "(", ")": return 4
        default: return 0
        }
    }

    /// The button image to use for a certain action.
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage(for: keyboardContext)
    }

    /// The content scale factor to use for a certain action.
    open func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat {
        switch keyboardContext.deviceType {
        case .pad: return 1.2
        default: return 1
        }
    }

    /// The button style to use for a certain action.
    open func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardStyle.Button {
        .init(
            backgroundColor: buttonBackgroundColor(for: action, isPressed: isPressed),
            foregroundColor: buttonForegroundColor(for: action, isPressed: isPressed),
            font: buttonFont(for: action),
            cornerRadius: buttonCornerRadius(for: action),
            border: buttonBorderStyle(for: action),
            shadow: buttonShadowStyle(for: action)
        )
    }

    /// The button text to use for a certain action, if any.
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText(for: keyboardContext)
    }


    // MARK: - Callouts

    /// The callout style to apply to callouts.
    open var calloutStyle: KeyboardStyle.Callout {
        var style = KeyboardStyle.Callout.standard
        let button = buttonStyle(for: .character(""), isPressed: false)
        style.buttonCornerRadius = button.cornerRadius ?? 5
        return style
    }

    /// The style to apply to ``ActionCallout`` views.
    open var actionCalloutStyle: KeyboardStyle.ActionCallout {
        var style = KeyboardStyle.ActionCallout.standard
        style.callout = calloutStyle
        return style
    }

    /// The style to apply to ``InputCallout`` views.
    open var inputCalloutStyle: KeyboardStyle.InputCallout {
        var style = KeyboardStyle.InputCallout.standard
        style.callout = calloutStyle
        return style
    }


    // MARK: - Autocomplete

    /// The style to apply to ``Autocomplete/Toolbar`` views.
    public var autocompleteToolbarStyle: KeyboardStyle.AutocompleteToolbar {
        return .standard
    }


    // MARK: - Overridable Button Style Components

    /// The background color to use for a certain action.
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        let fullOpacity = keyboardContext.hasDarkColorScheme || isPressed
        return action.buttonBackgroundColor(for: keyboardContext, isPressed: isPressed)
            .opacity(fullOpacity ? 1 : 0.95)
    }

    /// The border style to use for a certain action.
    open func buttonBorderStyle(for action: KeyboardAction) -> KeyboardStyle.ButtonBorder {
        switch action {
        case .emoji, .emojiCategory, .none: return .noBorder
        default: return .standard
        }
    }

    /// The corner radius to use for a certain action.
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
        keyboardLayoutConfiguration.buttonCornerRadius
    }

    /// The font to use for a certain action.
    open func buttonFont(for action: KeyboardAction) -> KeyboardFont {
        let size = buttonFontSize(for: action)
        let font = KeyboardFont.system(size: size)
        guard let weight = buttonFontWeight(for: action) else { return font }
        return font.weight(weight)
    }

    /// The font size to use for a certain action.
    open func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        if let override = buttonFontSizePadOverride(for: action) { return override }
        if buttonImage(for: action) != nil { return 20 }
        if let override = buttonFontSizeActionOverride(for: action) { return override }
        let text = buttonText(for: action) ?? ""
        if action.isInputAction && text.isLowercased { return 26 }
        if action.isSystemAction || action.isPrimaryAction { return 16 }
        return 23
    }

    /// The font size to override for a certain action.
    func buttonFontSizeActionOverride(for action: KeyboardAction) -> CGFloat? {
        switch action {
        case .keyboardType(let type): return buttonFontSize(for: type)
        case .space: return 16
        default: return nil
        }
    }

    /// The font size to override for a certain iPad action.
    func buttonFontSizePadOverride(for action: KeyboardAction) -> CGFloat? {
        guard keyboardContext.deviceType == .pad else { return nil }
        let isLandscape = keyboardContext.interfaceOrientation.isLandscape
        guard isLandscape else { return nil }
        if action.isAlphabeticKeyboardTypeAction { return 22 }
        if action.isKeyboardTypeAction(.numeric) { return 22 }
        if action.isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }

    /// The font size to use for a certain keyboard type.
    open func buttonFontSize(for keyboardType: Keyboard.KeyboardType) -> CGFloat {
        switch keyboardType {
        case .alphabetic: return 15
        case .numeric: return 16
        case .symbolic: return 14
        default: return 14
        }
    }

    /// The font weight to use for a certain action.
    open func buttonFontWeight(for action: KeyboardAction) -> KeyboardFont.FontWeight? {
        if isGregorianAlpha { return .regular }
        switch action {
        case .backspace: return .regular
        case .character(let char): return char.isLowercased ? .light : nil
        default: return buttonImage(for: action) != nil ? .light : nil
        }
    }

    /// The foreground color to use for a certain action.
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.buttonForegroundColor(for: keyboardContext, isPressed: isPressed)
    }
    
    /// The shadow style to use for a certain action.
    open func buttonShadowStyle(for action: KeyboardAction) -> KeyboardStyle.ButtonShadow {
        switch action {
        case .characterMargin: return .noShadow
        case .emoji, .emojiCategory: return .noShadow
        case .none: return .noShadow
        default: return .standard
        }
    }
}


// MARK: - Internal, Testable Extensions

extension StandardKeyboardStyleProvider {

    var isGregorianAlpha: Bool {
        keyboardContext.keyboardType.isAlphabetic && keyboardContext.locale.matches(.georgian)
    }
}

extension KeyboardAction {

    var buttonBackgroundColorForAllStates: Color? {
        switch self {
        case .none: return .clear
        case .characterMargin: return .clearInteractable
        case .emoji: return .clearInteractable
        case .emojiCategory: return .clearInteractable
        default: return nil
        }
    }

    func buttonBackgroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonBackgroundColorForAllStates { return color }
        return isPressed ?
            buttonBackgroundColorForPressedState(for: context) :
            buttonBackgroundColorForIdleState(for: context)
    }

    func buttonBackgroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isUppercasedShiftAction { return buttonBackgroundColorForPressedState(for: context) }
        if isSystemAction { return .standardDarkButtonBackground(for: context) }
        if isPrimaryAction { return .blue }
        if isUppercasedShiftAction { return .standardButtonBackground(for: context) }
        return .standardButtonBackground(for: context)
    }

    func buttonBackgroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isSystemAction { return context.hasDarkColorScheme ? .standardButtonBackground(for: context) : .white }
        if isPrimaryAction { return context.hasDarkColorScheme ? .standardDarkButtonBackground(for: context) : .white }
        if isUppercasedShiftAction { return .standardDarkButtonBackground(for: context) }
        return .standardDarkButtonBackground(for: context)
    }

    var buttonForegroundColorForAllStates: Color? {
        switch self {
        case .none: return .clear
        case .characterMargin: return .clearInteractable
        default: return nil
        }
    }

    func buttonForegroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonForegroundColorForAllStates { return color }
        return isPressed ?
            buttonForegroundColorForPressedState(for: context) :
            buttonForegroundColorForIdleState(for: context)
    }

    func buttonForegroundColorForIdleState(for context: KeyboardContext) -> Color {
        let standard = Color.standardButtonForeground(for: context)
        if isSystemAction { return standard }
        if isPrimaryAction { return .white }
        return standard
    }

    func buttonForegroundColorForPressedState(for context: KeyboardContext) -> Color {
        let standard = Color.standardButtonForeground(for: context)
        if isSystemAction { return standard }
        if isPrimaryAction { return context.hasDarkColorScheme ? .white : standard }
        return standard
    }
}
