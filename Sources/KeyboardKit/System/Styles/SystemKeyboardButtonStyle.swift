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
        font: Font,
        cornerRadius: CGFloat,
        border: SystemKeyboardButtonBorderStyle = .noBorder,
        shadow: SystemKeyboardButtonShadowStyle) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.font = font
            self.cornerRadius = cornerRadius
            self.border = border
            self.shadow = shadow
        }
    
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let font: Font
    public let cornerRadius: CGFloat
    public let border: SystemKeyboardButtonBorderStyle
    public let shadow: SystemKeyboardButtonShadowStyle
}
