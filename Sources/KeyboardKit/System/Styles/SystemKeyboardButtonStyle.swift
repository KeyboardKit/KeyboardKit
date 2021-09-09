//
//  SystemKeyboardButtonBodyStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style defines the style of a system keyboard button.
 */
public struct SystemKeyboardButtonStyle {
    
    public init(
        backgroundColor: Color,
        foregroundColor: Color,
        cornerRadius: CGFloat,
        border: SystemKeyboardButtonBorderStyle = .noBorder,
        shadow: SystemKeyboardButtonShadowStyle) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.cornerRadius = cornerRadius
            self.border = border
            self.shadow = shadow
        }
    
    public init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Bool = false) {
            self.init(
                backgroundColor: appearance.buttonBackgroundColor(for: action, isPressed: isPressed),
                foregroundColor: appearance.buttonForegroundColor(for: action, isPressed: isPressed),
                cornerRadius: appearance.buttonCornerRadius(for: action),
                shadow: SystemKeyboardButtonShadowStyle(
                    color: appearance.buttonShadowColor(for: action),
                    size: 1)
            )
        }
    
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let cornerRadius: CGFloat
    public let border: SystemKeyboardButtonBorderStyle
    public let shadow: SystemKeyboardButtonShadowStyle
}
