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
     The button image to use for a certain `action`, if any.
     */
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage(
            for: context)
    }
    
    /**
     The button text to use for a certain `action`, if any.
     */
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText(
            for: context)
    }
    
    /**
     The input callout style to apply when showing a callout
     that shows the currently pressed key.
     */
    open func inputCalloutStyle() -> InputCalloutStyle {
        var style = InputCalloutStyle.standard
        let button = systemKeyboardButtonStyle(for: .character(""), isPressed: false)
        style.callout.buttonCornerRadius = button.cornerRadius
        return style
    }
    
    /**
     The secondary input callout style to apply when showing
     a callout that shows secondary input actions.
     */
    open func secondaryInputCalloutStyle() -> SecondaryInputCalloutStyle {
        var style = SecondaryInputCalloutStyle.standard
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
            backgroundColor: backgroundColor(for: action, isPressed: isPressed),
            foregroundColor: foregroundColor(for: action, isPressed: isPressed),
            font: font(for: action),
            cornerRadius: layoutConfig.buttonCornerRadius,
            border: .standard,
            shadow: .standard)
    }
}

private extension StandardKeyboardAppearance {
    
    func backgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        let fullOpacity = context.colorScheme == .dark || isPressed
        return action.standardButtonBackgroundColor(
            for: context,
            isPressed: isPressed)
            .opacity(fullOpacity ? 1 : 0.95)
    }
    
    func font(for action: KeyboardAction) -> Font {
        let rawFont = action.standardButtonFont(for: context)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    func fontWeight(for action: KeyboardAction) -> Font.Weight? {
        if buttonImage(for: action) != nil { return .light }
        return action.standardButtonFontWeight(for: context)
    }
    
    func foregroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.standardButtonForegroundColor(
            for: context,
            isPressed: isPressed)
    }
}
