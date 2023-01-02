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
 and functions to customize the appearance. For instance, to
 change the background color of inpout keys only, you can do
 it like this:

 ```swift
 class MyAppearance: StandardKeyboardAppearance {

     override func buttonStyle(
         for action: KeyboardAction,
         isPressed: Bool
     ) -> KeyboardButtonStyle {
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
     
     You can override this function to customize this style.
     */
    open func actionCalloutStyle() -> ActionCalloutStyle {
        var style = ActionCalloutStyle.standard
        let button = buttonStyle(for: .character(""), isPressed: false)
        style.callout.buttonCornerRadius = button.cornerRadius
        return style
    }
    
    /**
     The button image to use for a certain `action`, if any.
     
     You can override this function to customize the default
     button image that is used for an action.
     */
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage(for: context)
    }
    
    /**
     The button style to use for a certain `action`, given a
     certain `isPressed` state.
     
     You can override this function to customize this style.
     */
    open func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardButtonStyle {
        KeyboardButtonStyle(
            backgroundColor: buttonBackgroundColor(for: action, isPressed: isPressed),
            foregroundColor: buttonForegroundColor(for: action, isPressed: isPressed),
            font: buttonFont(for: action),
            cornerRadius: buttonCornerRadius(for: action),
            border: buttonBorderStyle(for: action),
            shadow: buttonShadowStyle(for: action))
    }
    
    /**
     The button text to use for a certain `action`, if any.
     
     You can override this function to customize the default
     button text that is used for an action.
     */
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText(for: context)
    }
    
    /**
     The style to apply when presenting an ``InputCallout``.
     
     You can override this function to customize this style.
     */
    open func inputCalloutStyle() -> InputCalloutStyle {
        var style = InputCalloutStyle.standard
        let button = buttonStyle(for: .character(""), isPressed: false)
        style.callout.buttonCornerRadius = button.cornerRadius
        return style
    }
    
    
    // MARK: - Overridable Button Style Components
    
    /**
     The button background color to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        let fullOpacity = context.hasDarkColorScheme || isPressed
        return action.buttonBackgroundColor(for: context, isPressed: isPressed)
            .opacity(fullOpacity ? 1 : 0.95)
    }
    
    /**
     The button botder style to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonBorderStyle(for action: KeyboardAction) -> KeyboardButtonBorderStyle {
        switch action {
        case .emoji, .emojiCategory, .none: return .noBorder
        default: return .standard
        }
    }
    
    /**
     The button corner radius to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
        layoutConfig.buttonCornerRadius
    }
    
    /**
     The button font to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = Font.system(size: buttonFontSize(for: action))
        guard let weight = buttonFontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    /**
     The button font size to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
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
    
    /**
     The button font weight to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonFontWeight(for action: KeyboardAction) -> Font.Weight? {
        if buttonImage(for: action) != nil { return .light }
        switch action {
        case .character(let char): return char.isLowercased ? .light : nil
        default: return nil
        }
    }
    
    /**
     The button foreground color to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.buttonForegroundColor(for: context, isPressed: isPressed)
    }
    
    /**
     The button shadow style to use for a certain action.
     
     You can override this function to customize this single
     button style property.
     */
    open func buttonShadowStyle(for action: KeyboardAction) -> KeyboardButtonShadowStyle {
        switch action {
        case .characterMargin: return .noShadow
        case .emoji, .emojiCategory: return .noShadow
        case .none: return .noShadow
        default: return .standard
        }
    }
}


// MARK: - Internal, Testable Extensions

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
        if isPrimaryAction { return .blue }
        if isUppercasedShiftAction { return .standardButtonBackground(for: context) }
        if isSystemAction { return .standardDarkButtonBackground(for: context) }
        return .standardButtonBackground(for: context)
    }
    
    func buttonForegroundColorForAllStates() -> Color? {
        switch self {
        case .none: return .clear
        case .characterMargin: return .clearInteractable
        default: return nil
        }
    }
    
    func buttonBackgroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return context.hasDarkColorScheme ? .standardDarkButtonBackground(for: context) : .white }
        if isUppercasedShiftAction { return .standardDarkButtonBackground(for: context) }
        if isSystemAction { return context.hasDarkColorScheme ? .standardButtonBackground(for: context) : .white }
        return .standardDarkButtonBackground(for: context)
    }
    
    func buttonForegroundColor(for context: KeyboardContext, isPressed: Bool = false) -> Color {
        if let color = buttonForegroundColorForAllStates() { return color }
        return isPressed ?
            buttonForegroundColorForPressedState(for: context) :
            buttonForegroundColorForIdleState(for: context)
    }
    
    func buttonForegroundColorForIdleState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return .white }
        return .standardButtonForeground(for: context)
    }
    
    func buttonForegroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isPrimaryAction { return context.hasDarkColorScheme ? .white : .standardButtonForeground(for: context) }
        return .standardButtonForeground(for: context)
    }
}
