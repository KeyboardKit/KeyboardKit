//
//  StandardKeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This standard appearance returns styles that replicates the
 look of a native system keyboard.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
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
     The style to apply to system keyboard buttons when they
     are presenting the provided action.
     */
    open func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle {
        SystemKeyboardButtonStyle(
            backgroundColor: action.standardButtonBackgroundColor(for: context, isPressed: isPressed),
            foregroundColor: action.standardButtonForegroundColor(for: context, isPressed: isPressed),
            font: font(for: action),
            cornerRadius: .standardKeyboardButtonCornerRadius(for: context.device),
            border: .noBorder,
            shadow: SystemKeyboardButtonShadowStyle(
                color: action.standardButtonShadowColor(for: context),
                size: 1)
        )
    }
    
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        systemKeyboardButtonStyle(for: action, isPressed: isPressed)
            .backgroundColor
    }
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
        systemKeyboardButtonStyle(for: action, isPressed: false)
            .cornerRadius
    }
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    open func buttonFont(for action: KeyboardAction) -> Font {
        font(for: action)
    }
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        systemKeyboardButtonStyle(for: action, isPressed: isPressed)
            .foregroundColor
    }
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    open func buttonShadowColor(for action: KeyboardAction) -> Color {
        systemKeyboardButtonStyle(for: action, isPressed: false)
            .shadow.color
    }
}

private extension StandardKeyboardAppearance {
    
    func font(for action: KeyboardAction) -> Font {
        let rawFont = action.standardButtonFont(for: context)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    func fontWeight(for action: KeyboardAction) -> Font.Weight? {
        if buttonImage(for: action) != nil { return .light }
        return action.standardButtonFontWeight(for: context)
    }
}
