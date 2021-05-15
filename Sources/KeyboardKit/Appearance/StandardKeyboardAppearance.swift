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
 This standard appearance returns a style that mimics native
 system keyboards.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
    open var keyboardBackgroundColor: Color { .clear }
    
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.standardButtonBackgroundColor(for: context, isPressed: isPressed)
    }
    
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat {
        .standardKeyboardButtonCornerRadius(for: context.device)
    }
    
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = action.standardButtonFont(for: context)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.standardButtonForegroundColor(for: context, isPressed: isPressed)
    }
    
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage(for: context)
    }
    
    open func buttonShadowColor(for action: KeyboardAction) -> Color {
        action.standardButtonShadowColor(for: context)
    }
    
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText(for: context)
    }
}

private extension StandardKeyboardAppearance {
    
    func fontWeight(for action: KeyboardAction) -> Font.Weight? {
        if buttonImage(for: action) != nil { return .light }
        return action.standardButtonFontWeight(for: context)
    }
}
