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
 
 You can inherit this class then override any parts you like
 to customize the standard appearance.
 
 `TODO` Unit test.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
    open func buttonBackgroundColor(for action: KeyboardAction) -> Color {
        action.standardButtonBackgroundColor(for: context)
    }
    
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = Font(action.standardButtonFont)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    open func buttonForegroundColor(for action: KeyboardAction) -> Color {
        action.standardButtonForegroundColor(for: context)
    }
    
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage
    }
    
    open func buttonShadowColor(for action: KeyboardAction) -> Color {
        action.standardButtonShadowColor(for: context)
    }
    
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText
    }
}

private extension StandardKeyboardAppearance {
    
    func fontWeight(for action: KeyboardAction) -> UIFont.Weight? {
        let hasImage = buttonImage(for: action) != nil
        return hasImage ? .light : nil
    }
}
