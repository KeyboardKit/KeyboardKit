//
//  KeyboardStyle+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI


// MARK: - Styles

public extension KeyboardStyle {
    
    /**
     This style defines the style of a keyboard button.
     
     This type has no `standard` style, since a button style
     depends on many factors.
     */
    struct Button: Codable, Equatable {
        
        /**
         Create a keyboard button style.
         
         - Parameters:
           - backgroundColor: The background color to apply to the button, by default `nil`.
           - foregroundColor: The border color to apply to the button, by default `nil`.
           - font: The font to apply to the button, by default `nil`.
           - cornerRadius: The corner radius to apply to the button, by default `nil`.
           - border: The border style to apply to the button, by default `nil`.
           - shadow: The shadow style to apply to the button, by default `nil`.
           - pressedOverlayColor: The color to overlay the background color when pressed, by default `nil`.
         */
        public init(
            backgroundColor: Color? = nil,
            foregroundColor: Color? = nil,
            font: KeyboardFont? = nil,
            cornerRadius: CGFloat? = nil,
            border: BorderStyle? = nil,
            shadow: ShadowStyle? = nil,
            pressedOverlayColor: Color? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.font = font
            self.cornerRadius = cornerRadius
            self.borderColor = border?.color
            self.borderSize = border?.size
            self.shadowColor = shadow?.color
            self.shadowSize = shadow?.size
            self.pressedOverlayColor = pressedOverlayColor
        }
        
        public typealias BorderStyle = KeyboardStyle.ButtonBorder
        public typealias ShadowStyle = KeyboardStyle.ButtonShadow
        
        /// The background color to apply to the button.
        public var backgroundColor: Color?
        
        /// The border color to apply to the button.
        public var foregroundColor: Color?
        
        /// The font to apply to the button.
        public var font: KeyboardFont?
        
        /// The corner radius to apply to the button.
        public var cornerRadius: CGFloat?
        
        /// The border color to apply to the button.
        public var borderColor: Color? {
            didSet {
                guard borderColor != nil, borderSize == nil else { return }
                borderSize = 1
            }
        }
        
        /// The border style to apply to the button.
        public var border: BorderStyle? {
            get {
                guard let borderSize, let borderColor else { return nil }
                return .init(color: borderColor, size: borderSize)
            } set {
                borderColor = newValue?.color
                borderSize = newValue?.size
            }
        }
        
        /// The border size to apply to the button.
        public var borderSize: CGFloat? {
            didSet {
                guard borderSize != nil, borderColor == nil else { return }
                borderColor = .black
            }
        }
        
        /// The shadow color to apply to the button.
        public var shadowColor: Color? {
            didSet {
                guard shadowColor != nil, shadowSize == nil else { return }
                shadowSize = 1
            }
        }
        
        /// The shadow size to apply to the button.
        public var shadowSize: CGFloat? {
            didSet {
                guard shadowSize != nil, shadowColor == nil else { return }
                shadowColor = .standardButtonShadow
            }
        }
        
        /// The shadow style to apply to the button.
        public var shadow: ShadowStyle? {
            get {
                guard let shadowSize, let shadowColor else { return nil }
                return .init(color: shadowColor, size: shadowSize)
            } set {
                shadowColor = newValue?.color
                shadowSize = newValue?.size
            }
        }
        
        /// The color to apply when the button is pressed.
        public var pressedOverlayColor: Color?
    }
    
    /**
     This style defines the border of a keyboard button.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ButtonBorder: Codable, Equatable {
        
        /**
         Create akeyboard button border style.
         
         - Parameters:
           - color: The color of the border, by default `.clear`.
           - size: The size of the border, by default `0`.
         */
        public init(
            color: Color = .clear,
            size: CGFloat = 0
        ) {
            self.color = color
            self.size = size
        }
        
        /// The color of the border.
        public var color: Color
        
        /// The size of the border.
        public var size: CGFloat
    }
    
    /**
     This style defines the shadow of a keyboard button.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ButtonShadow: Codable, Equatable {
        
        /**
         Create a keyboard button shadow style.
         
         - Parameters:
           - color: The color of the shadow, by default `.standardButtonShadow`.
           - size: The size of the shadow, by default `1`.
         */
        public init(
            color: Color = .standardButtonShadow,
            size: CGFloat = 1
        ) {
            self.color = color
            self.size = size
        }
        
        /// The color of the shadow.
        public var color: Color
        
        /// The size of the shadow.
        public var size: CGFloat
    }
}

public extension KeyboardStyle.Button {

    /**
     Override this style with another style. This will apply
     all non-optional properties from the provided style.
     */
    func extended(with style: KeyboardStyle.Button) -> Self {
        var result = self
        result.backgroundColor = style.backgroundColor ?? backgroundColor
        result.foregroundColor = style.foregroundColor ?? foregroundColor
        result.font = style.font ?? font
        result.cornerRadius = style.cornerRadius ?? cornerRadius
        result.border = style.border ?? border
        result.shadow = style.shadow ?? shadow
        return result
    }

    /**
     A spacer button style means that the button will not be
     visually detectable, but still rendered.
     */
    static let spacer = Self(
        backgroundColor: .clear,
        foregroundColor: .clear,
        font: .body,
        cornerRadius: 0,
        border: .noBorder,
        shadow: .noShadow
    )
}


// MARK: - Standard Styles

public extension KeyboardStyle.ButtonBorder {
    
    /**
     This style applies no border.
     */
    static var noBorder = Self()
    
    /**
     The standard button border style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

public extension KeyboardStyle.ButtonShadow {
    
    /**
     This style applies no shadow.
     */
    static var noShadow = Self(color: .clear)
    
    /**
     The standard button shadow style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}


// MARK: - Preview Styles

extension KeyboardStyle.Button {

    static let preview1 = Self(
        backgroundColor: .yellow,
        foregroundColor: .white,
        font: .body,
        cornerRadius: 20,
        border: .previewStyle1,
        shadow: .previewStyle1
    )

    static let preview2 = Self(
        backgroundColor: .purple,
        foregroundColor: .yellow,
        font: .headline,
        cornerRadius: 10,
        border: .previewStyle2,
        shadow: .previewStyle2
    )
}

extension KeyboardStyle.ButtonBorder {
    
    static let previewStyle1 = Self(
        color: .red,
        size: 3
    )
    
    static let previewStyle2 = Self(
        color: .blue,
        size: 5
    )
}

extension KeyboardStyle.ButtonShadow {
    
    static let previewStyle1 = Self(
        color: .blue,
        size: 4
    )
    
    static let previewStyle2 = Self(
        color: .green,
        size: 8
    )
}
