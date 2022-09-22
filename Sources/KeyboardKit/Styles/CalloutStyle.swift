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
 type of view that is presented above a keyboard button, e.g.
 when a user types or long presses a key to get more actions.
 
 You can modify the ``standard`` style to change the default,
 global style of all callout views.
 */
public struct CalloutStyle: Equatable {
    
    /**
     Create a callout style.
     
     When customizing these values, note that some are meant
     to fit the context in which a callout is presented, e.g.
     ``buttonCornerRadius``, which should use the same value
     as the button that the callout is presented over.
     
     Only customize the parameters you need to customize and
     use the default values for all other parameters.
     
     - Parameters:
       - backgroundColor: The background color of the entire callout.
       - borderColor: The border color of the entire callout.
       - buttonCornerRadius: The corner radius of the callout edges.
       - buttonInset: The inset to apply to the button overlay.
       - cornerRadius: The corner radius of the callout edges.
       - curveSize: The size of the curve that links the button overlay and
       - shadowColor: The shadow of the entire callout.
       - shadowRadius: The shadow radius of the entire callout.
       - textColor: The text color to use in the callout.
     */
    public init(
        backgroundColor: Color = .standardButtonBackground,
        borderColor: Color = Color.black.opacity(0.5),
        buttonCornerRadius: CGFloat = 4,
        buttonInset: CGSize = CGSize.zero,
        cornerRadius: CGFloat = 10,
        curveSize: CGSize = CGSize(width: 8, height: 15),
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 5,
        textColor: Color = .primary
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.buttonCornerRadius = buttonCornerRadius
        self.buttonInset = buttonInset
        self.cornerRadius = cornerRadius
        self.curveSize = curveSize
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.textColor = textColor
    }
    
    /**
     The background color of the entire callout.
     */
    public var backgroundColor: Color
    
    /**
     The border color of the entire callout.
     */
    public var borderColor: Color
    
    /**
     The corner radius of the button overlay.
     */
    public var buttonCornerRadius: CGFloat
    
    /**
     The inset to apply to the part of the callout that will
     overlap the tapped button.
     
     This must be used in a `SystemKeyboard`, where a button
     has an intrinsic padding, which cause the buttons to be
     larger than the visual area.
     */
    public var buttonInset: CGSize
    
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
     This standard style aims to mimic the native iOS style.
     */
    static var standard = CalloutStyle()
}

extension CalloutStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = CalloutStyle(
        backgroundColor: .red,
        borderColor: .white,
        buttonCornerRadius: 10,
        shadowColor: .green,
        shadowRadius: 3,
        textColor: .black)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = CalloutStyle(
        backgroundColor: .green,
        borderColor: .white,
        buttonCornerRadius: 20,
        shadowColor: .black,
        shadowRadius: 10,
        textColor: .red)
}
