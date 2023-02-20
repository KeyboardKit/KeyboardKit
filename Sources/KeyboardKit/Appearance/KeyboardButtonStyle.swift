//
//  KeyboardButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style defines the style of a system keyboard button.
 
 Unlike other styles, this has no `standard` style, since it
 depends on so many factors, like button type, layout config
 etc. Instead, use a ``KeyboardAppearance``to resolve styles
 for certain actions.
 */
public struct KeyboardButtonStyle {
    
    /**
     Create a system keyboard button style.
     
     - Parameters:
       - backgroundColor: The background color to apply to the button.
       - foregroundColor: The border color to apply to the button.
       - font: The font to apply to the button.
       - cornerRadius: The corner radius to apply to the button.
       - border: The border style to apply to the button, by default ``KeyboardButtonBorderStyle/standard``.
       - shadow: The shadow style to apply to the button, by default ``KeyboardButtonShadowStyle/standard.
     */
    public init(
        backgroundColor: Color,
        foregroundColor: Color,
        font: Font,
        cornerRadius: CGFloat,
        border: KeyboardButtonBorderStyle = .standard,
        shadow: KeyboardButtonShadowStyle = .standard
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.border = border
        self.shadow = shadow
    }

    /**
     The background color to apply to the button.
     */
    public var backgroundColor: Color
    
    /**
     The border color to apply to the button.
     */
    public var foregroundColor: Color
    
    /**
     The font to apply to the button.
     */
    public var font: Font
    
    /**
     The corner radius to apply to the button.
     */
    public var cornerRadius: CGFloat
    
    /**
     The border style to apply to the button.
     */
    public var border: KeyboardButtonBorderStyle
    
    /**
     The shadow style to apply to the button.
     */
    public var shadow: KeyboardButtonShadowStyle
}

public extension KeyboardButtonStyle {

    /**
     A spacer button style means that the button will not be
     visually detectable, but still rendered.
     */
    static let spacer = KeyboardButtonStyle(
        backgroundColor: .clear,
        foregroundColor: .clear,
        font: .body,
        cornerRadius: 0,
        border: .noBorder,
        shadow: .noShadow
    )
}

extension KeyboardButtonStyle {
    
    /**
     This internal style is only used in previews.
     */
    static let preview1 = KeyboardButtonStyle(
        backgroundColor: .yellow,
        foregroundColor: .white,
        font: .body,
        cornerRadius: 20,
        border: .previewStyle1,
        shadow: .previewStyle1
    )
    
    /**
     This internal style is only used in previews.
     */
    static let preview2 = KeyboardButtonStyle(
        backgroundColor: .purple,
        foregroundColor: .yellow,
        font: .headline,
        cornerRadius: 10,
        border: .previewStyle2,
        shadow: .previewStyle2
    )
}
