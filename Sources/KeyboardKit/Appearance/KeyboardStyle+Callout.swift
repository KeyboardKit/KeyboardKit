//
//  KeyboardStyle+Callout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style can be used to style callout views.
     
     Callout views are presented over a keyboard button, e.g.
     when a user types or long presses a key.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct Callout: Codable, Equatable {
        
        /**
         Create a callout style.
         
         When creating a custom callout style, note that the
         style has some components that are meant to fit the
         current context. For instance, ``buttonCornerRadius``
         should probably be the same as the corner radius of
         the button that is used to present the callout.
         
         Only customize the parameters you need to customize
         and use the default values for all other parameters.
         
         - Parameters:
           - backgroundColor: The background color of the entire callout, by default `.standardButtonBackground`.
           - borderColor: The border color of the entire callout, by default transparent `.black`.
           - buttonCornerRadius: The corner radius of the callout edges, by default `4`.
           - buttonInset: The inset to apply to the button overlay, by default transparent `.zero`.
           - cornerRadius: The corner radius of the callout edges, by default transparent `10`.
           - curveSize: The size of the curve that links the button overlay and callout, by default transparent `8x15`.
           - shadowColor: The shadow of the entire callout, by default transparent transparent `.black`.
           - shadowRadius: The shadow radius of the entire callout, by default transparent `5`.
           - textColor: The text color to use in the callout, by default `.primary`.
         */
        public init(
            backgroundColor: Color = .standardButtonBackground,
            borderColor: Color = Color.black.opacity(0.5),
            buttonCornerRadius: CGFloat = 5,
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
         The insets to apply to the part of the callout that
         overlaps the tapped button.
         
         This must be used in a ``SystemKeyboard`` where the
         buttons have an intrinsic padding, which causes the
         buttons to be larger than the visual area.
         */
        public var buttonInset: CGSize
        
        /**
         The corner radius of the callout edges.
         */
        public var cornerRadius: CGFloat
        
        /**
         The size of the curve that links the button overlay
         and the callout bubble.
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
}

public extension KeyboardStyle.Callout {
    
    /**
     The standard callout style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

extension KeyboardStyle.Callout {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = Self(
        backgroundColor: .red,
        borderColor: .white,
        buttonCornerRadius: 10,
        shadowColor: .green,
        shadowRadius: 3,
        textColor: .black
    )
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = Self(
        backgroundColor: .green,
        borderColor: .white,
        buttonCornerRadius: 20,
        shadowColor: .black,
        shadowRadius: 10,
        textColor: .red
    )
}
