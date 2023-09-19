//
//  KeyboardStyle+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI


// MARK: - Styles

public extension KeyboardStyle {
    
    /**
     This style can be used to style callout views, that are
     presented over a key, e.g. when typing or long pressing.
     
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
        
        /// The background color of the entire callout.
        public var backgroundColor: Color
        
        /// The border color of the entire callout.
        public var borderColor: Color
        
        /// The corner radius of the button overlay.
        public var buttonCornerRadius: CGFloat
        
        /// The insets of the parts that overlaps the button.
        public var buttonInset: CGSize
        
        /// The corner radius of the callout edges.
        public var cornerRadius: CGFloat
        
        /// The size of the callout curve.
        public var curveSize: CGSize
        
        /// The shadow of the entire callout.
        public var shadowColor: Color
        
        /// The shadow radius of the entire callout.
        public var shadowRadius: CGFloat
        
        /// The text color to use in the callout.
        public var textColor: Color
    }
    
    /**
     This style can be used with ``ActionCallout`` views.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ActionCallout: Codable, Equatable {
        
        /**
         Create an action callout style.
         
         - Parameters:
           - callout: The callout style to use, by default `.standard`.
           - font: The font to use in the callout, by default `.standardFont`.
           - maxButtonSize: The max button size, by default a `50` point square.
           - selectedBackgroundColor: The background color of the selected item, by default `.blue`.
           - selectedForegroundColor: The foreground color of the selected item, by default `.white`.
           - verticalOffset: The vertical offset of the action callout, by default `20` points on iPad devices and `0` otherwise.
           - verticalTextPadding: The vertical padding to apply to text in the callout, by default `6`.
         */
        public init(
            callout: KeyboardStyle.Callout = .standard,
            font: KeyboardFont = .init(.title3),
            maxButtonSize: CGSize = CGSize(width: 50, height: 50),
            selectedBackgroundColor: Color? = nil,
            selectedForegroundColor: Color? = nil,
            verticalOffset: CGFloat? = nil,
            verticalTextPadding: CGFloat = 6
        ) {
            self.callout = callout
            self.font = font
            self.maxButtonSize = maxButtonSize
            self.selectedBackgroundColor = selectedBackgroundColor ?? .blue
            self.selectedForegroundColor = selectedForegroundColor ?? .white
            let standardVerticalOffset: CGFloat = DeviceType.current == .pad ? 20 : 0
            self.verticalOffset = verticalOffset ?? standardVerticalOffset
            self.verticalTextPadding = verticalTextPadding
        }
        
        /// The style to use for the callout bubble.
        public var callout: KeyboardStyle.Callout
        
        /// The font to use in the callout.
        public var font: KeyboardFont
        
        /// The max size of the callout buttons.
        public var maxButtonSize: CGSize
        
        /// The background color of the selected item.
        public var selectedBackgroundColor: Color
        
        /// The foreground color of the selected item.
        public var selectedForegroundColor: Color
        
        /// The vertical offset to apply to the callout.
        public var verticalOffset: CGFloat
        
        /// The vertical padding of the callout text.
        public var verticalTextPadding: CGFloat
    }
    
    /**
     This style can be used with ``InputCallout`` views.
     
     The ``calloutSize`` specifies a **minimum** size to use.
     If other factors, like button size, curve size, padding,
     etc. requires it to be larger, the size will be ignored.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct InputCallout: Codable, Equatable {
        
        /**
         Create an input callout style.
         
         - Parameters:
           - callout: The callout style to use, by default `.standard`.
           - calloutPadding: The padding to apply to the callout content, by default `2`.
           - calloutSize: The minimum size of the callout bubble, by default `.largeTitle .light`.
           - font: The font to use in the callout.
         */
        public init(
            callout: KeyboardStyle.Callout = .standard,
            calloutPadding: CGFloat = 2,
            calloutSize: CGSize = CGSize(width: 0, height: 55),
            font: KeyboardFont = .init(.largeTitle, .light)
        ) {
            self.callout = callout
            self.calloutPadding = calloutPadding
            self.calloutSize = calloutSize
            self.font = font
        }
        
        /// The style to use for the callout bubble.
        public var callout: KeyboardStyle.Callout
        
        /// The padding to apply to the callout content.
        public var calloutPadding: CGFloat
        
        /// The minimum callout size above the button area.
        public var calloutSize: CGSize
        
        /// The font to use in the callout.
        public var font: KeyboardFont
    }
}


// MARK: - Standard Styles

public extension KeyboardStyle.Callout {
    
    /**
     The standard callout style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

public extension KeyboardStyle.ActionCallout {
    
    /**
     The standard action callout style.

     This can be changed to affect the global, default style.
    */
    static var standard = Self()
}

public extension KeyboardStyle.InputCallout {
    
    /**
     The standard input callout style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}


// MARK: - Preview Styles

extension KeyboardStyle.Callout {
    
    static var preview1 = Self(
        backgroundColor: .red,
        borderColor: .white,
        buttonCornerRadius: 10,
        shadowColor: .green,
        shadowRadius: 3,
        textColor: .black
    )
    
    static var preview2 = Self(
        backgroundColor: .green,
        borderColor: .white,
        buttonCornerRadius: 20,
        shadowColor: .black,
        shadowRadius: 10,
        textColor: .red
    )
}
