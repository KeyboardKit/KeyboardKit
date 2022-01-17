//
//  StandardKeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

/**
 This standard appearance returns styles that replicates the
 look of a native system keyboard.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    /**
     Create a standard keyboard appearance intance.
     
     - Parameters:
       - context: The context to use for resolving styles.
     */
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    
    private let context: KeyboardContext
    
    private var layoutConfig: KeyboardLayoutConfiguration {
        .standard(for: context)
    }
    
    
    /**
     The style to apply when presenting an ``ActionCallout``.
     */
    open func actionCalloutStyle() -> ActionCalloutStyle {
        var style = ActionCalloutStyle.standard
        let button = systemKeyboardButtonStyle(for: .character(""), isPressed: false)
        style.callout.buttonCornerRadius = button.cornerRadius
        return style
    }
    
    /**
     The button image to use for a certain `action`, if any.
     */
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage(for: context)
    }
    
    /**
     The button text to use for a certain `action`, if any.
     */
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText(for: context)
    }
    
    /**
     The style to apply when presenting an ``InputCallout``.
     */
    open func inputCalloutStyle() -> InputCalloutStyle {
        var style = InputCalloutStyle.standard
        let button = systemKeyboardButtonStyle(for: .character(""), isPressed: false)
        style.callout.buttonCornerRadius = button.cornerRadius
        return style
    }
    
    /**
     The system keybard button style to use for the provided
     `action` given a certain `isPressed` state.
     */
    open func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle {
        SystemKeyboardButtonStyle(
            backgroundColor: buttonBackgroundColor(for: action, isPressed: isPressed),
            foregroundColor: buttonForegroundColor(for: action, isPressed: isPressed),
            font: buttonFont(for: action),
            cornerRadius: buttonCornerRadius(for: action),
            border: buttonBorderStyle(for: action),
            shadow: buttonShadowStyle(for: action))
    }
    
    
    // MARK: - Overridable Button Style Components
    
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        let fullOpacity = context.colorScheme == .dark || isPressed
        return action.buttonBackgroundColor(for: context, isPressed: isPressed)
            .opacity(fullOpacity ? 1 : 0.95)
    }
    
    open func buttonBorderStyle(for action: KeyboardAction) -> SystemKeyboardButtonBorderStyle {
        switch action {
        case .emoji, .emojiCategory, .none: return .noBorder
        default: return .standard
        }
    }
    
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
        layoutConfig.buttonCornerRadius
    }
    
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = Font.system(size: buttonFontSize(for: action))
        guard let weight = buttonFontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    open func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        if buttonImage(for: action) != nil { return 20 }
        switch action {
        case .keyboardType(let type): return type.standardButtonFontSize(for: context)
        case .space: return 16
        default: break
        }
        
        let text = buttonText(for: action) ?? ""
        if action.isInputAction && text.isLowercased { return 26 }
        if action.isSystemAction || action.isPrimaryAction { return 16 }
        return 23
    }
    
    open func buttonFontWeight(for action: KeyboardAction) -> Font.Weight? {
        if buttonImage(for: action) != nil { return .light }
        switch action {
        case .character(let char): return char.isLowercased ? .light : nil
        default: return nil
        }
    }
    
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.buttonForegroundColor(for: context, isPressed: isPressed)
    }
    
    open func buttonShadowStyle(for action: KeyboardAction) -> SystemKeyboardButtonShadowStyle {
        switch action {
        case .characterMargin, .emoji, .emojiCategory, .none: return .noShadow
        default: return .standard
        }
    }
}


// MARK: - Internal, Testable Extensions

extension KeyboardAction {
    
    func buttonBackgroundColorForAllStates() -> Color? {
        switch self {
        case .none: return .clear
        case .characterMargin: return .clearInteractable
        case .emoji: return .clearInteractable
        case .emojiCategory: return .clearInteractable
        default: return nil
        }
    }
    
    func buttonBackgroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonBackgroundColorForAllStates() { return color }
        return isPressed ?
            buttonBackgroundColorForPressedState(for: context) :
            buttonBackgroundColorForIdleState(for: context)
    }
    
    func buttonBackgroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return .blue }
        if isUppercaseShift { return .standardButtonBackgroundColor(for: context) }
        if isSystemAction { return .standardDarkButtonBackgroundColor(for: context) }
        return .standardButtonBackgroundColor(for: context)
    }
    
    func buttonForegroundColorForAllStates() -> Color? {
        switch self {
        case .none: return .clear
        case .characterMargin: return .clearInteractable
        default: return nil
        }
    }
    
    func buttonBackgroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return context.colorScheme == .dark ? .standardDarkButtonBackgroundColor(for: context) : .white }
        if isUppercaseShift { return .standardDarkButtonBackgroundColor(for: context) }
        if isSystemAction { return context.colorScheme == .dark ? .standardButtonBackgroundColor(for: context) : .white }
        return .standardDarkButtonBackgroundColor(for: context)
    }
    
    func buttonForegroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonForegroundColorForAllStates() { return color }
        return isPressed ?
            buttonForegroundColorForPressedState(for: context) :
            buttonForegroundColorForIdleState(for: context)
    }
    
    func buttonForegroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return .white }
        return .standardButtonForegroundColor(for: context)
    }
    
    func buttonForegroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return context.colorScheme == .dark ? .white : .standardButtonForegroundColor(for: context) }
        return .standardButtonForegroundColor(for: context)
    }
}
