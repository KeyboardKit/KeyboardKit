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
     The system keybard button style to use for the provided
     `action` given a certain `isPressed` state.
     */
    open func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle {
        SystemKeyboardButtonStyle(
            backgroundColor: action.standardButtonBackgroundColor(for: context, isPressed: isPressed),
            foregroundColor: action.standardButtonForegroundColor(for: context, isPressed: isPressed),
            font: font(for: action),
            cornerRadius: layoutConfig.buttonCornerRadius,
            border: .standard,
            shadow: SystemKeyboardButtonShadowStyle(
                color: action.standardButtonShadowColor(for: context),
                size: 1)
        )
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
