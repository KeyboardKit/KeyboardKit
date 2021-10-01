//
//  CalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct can be used to style callout views, which are a
 type of view that is presented above a keyboard button.
 
 You can modify the `.standard` style instance to change the
 standard global style of all callout views.
 */
public struct CalloutStyle {
    
    /**
     Create a callout style.
     
     - Parameters:
       - backgroundColor: The background color to apply to the entire callout.
       - borderColor: The border color to apply to the entire callout.
       - buttonOverlayInset: The inset to apply to the button overlay.
       - cornerRadius: The corner radius of the callout edges.
       - curveSize: The size of the curve that links the button overlay and
       - shadowColor: The shadow of the entire callout.
       - shadowRadius: The shadow radius of the entire callout.
       - textColor: The text color to use in the callout.
     */
    public init(
        backgroundColor: Color = .standardButtonBackground,
        borderColor: Color = Color.black.opacity(0.5),
        buttonOverlayInset: CGSize = CGSize.zero,
        cornerRadius: CGFloat = 10,
        curveSize: CGSize = CGSize(width: 8, height: 15),
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 5,
        textColor: Color = .primary) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.buttonOverlayInset = buttonOverlayInset
        self.cornerRadius = cornerRadius
        self.curveSize = curveSize
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.textColor = textColor
    }
    
    /**
     The background color to apply to the entire callout.
     */
    public var backgroundColor: Color
    
    /**
     The border color to apply to the entire callout.
     */
    public var borderColor: Color
    
    /**
     The inset to apply to the part of the callout that will
     overlap the tapped button.
     
     This must be used in a `SystemKeyboard`, where a button
     has an intrinsic padding, which cause the buttons to be
     larger than the visual area.
     */
    public var buttonOverlayInset: CGSize
    
    /**
     The corner radius of the callout edges.
     */
    public var cornerRadius: CGFloat
    
    /**
     The size of the curve that links the button overlay and
     the callout bubble.
     */
    public var curveSize: CGSize
    
    /**
     The shadow of the entire callout.
     */
    public var shadowColor: Color
    
    /**
     The shadow radius of the entire callout.
     */
    public var shadowRadius: CGFloat
    
    /**
     The text color to use in the callout.
     */
    public var textColor: Color
}

public extension CalloutStyle {
    
    /**
     This standard style will be used by default. It aims to
     look like a native system keyboard's callout.
     */
    static var standard = CalloutStyle()
}
