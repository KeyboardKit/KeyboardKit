//
//  KeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This protocol can be implemented by any classes that can be
 used to provide appearance information for keyboard actions.
 
 Unlike a style, an appearance is contextual. It requires an
 implementation, while a style is just a struct. You can use
 an appearance to generate styles that can be applied to the
 keyboard and its buttons.
 
 `KeyboardKit` will automatically create a standard instance
 when the keyboard input view controller is created. You can
 use the standard instance as is or replace it with a custom
 one if you want to customize your keyboard.
 */
public protocol KeyboardAppearance {
    
    func buttonImage(for action: KeyboardAction) -> Image?
    func buttonText(for action: KeyboardAction) -> String?
    func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle
    
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    func buttonCornerRadius(for action: KeyboardAction) -> CGFloat
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    func buttonFont(for action: KeyboardAction) -> Font
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color
    @available(*, deprecated, message: "Use systemKeyboardButtonStyle instead")
    func buttonShadowColor(for action: KeyboardAction) -> Color
}
