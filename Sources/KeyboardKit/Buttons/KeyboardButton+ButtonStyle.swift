//
//  KeyboardButton+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /// This style can be used to modify the visual style of
    /// the ``KeyboardButton/Button`` component.
    ///
    /// The style is also used by the many button components.
    ///
    /// You can apply this view style with the view modifier
    /// `keyboardButtonStyle(_:)`.
    ///
    /// Unlike most other styles, the style doesn't yet have
    /// a standard style, due to the complexities of how the
    /// button looks on different platforms. Standard styles
    /// will be added in KeyboardKit 9 (TODO).
    struct ButtonStyle: Codable, Equatable {
        
        /// Create a keyboard button style.
        ///
        /// - Parameters:
        ///   - background: The background to apply to the button, by default `nil`.
        ///   - backgroundColor: The background color to apply to the button, by default `nil`.
        ///   - foregroundColor: The border color to apply to the button, by default `nil`.
        ///   - font: The font to apply to the button, by default `nil`.
        ///   - cornerRadius: The corner radius to apply to the button, by default `nil`.
        ///   - border: The border style to apply to the button, by default `nil`.
        ///   - shadow: The shadow style to apply to the button, by default `nil`.
        ///   - pressedOverlayColor: The color to overlay the background color when pressed, by default `nil`.
        public init(
            background: Keyboard.Background? = nil,
            backgroundColor: Color? = nil,
            foregroundColor: Color? = nil,
            font: KeyboardFont? = nil,
            cornerRadius: CGFloat? = nil,
            border: BorderStyle? = nil,
            shadow: ShadowStyle? = nil,
            pressedOverlayColor: Color? = nil
        ) {
            self.background = background
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
        
        public typealias BorderStyle = KeyboardButton.ButtonBorderStyle
        public typealias ShadowStyle = KeyboardButton.ButtonShadowStyle
        
        /// The background style to apply to the button.
        public var background: Keyboard.Background?
        
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
                shadowColor = .keyboardButtonShadow
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
    
    /// This style defines the border of a keyboard button.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ButtonBorderStyle: Codable, Equatable {
        
        /// Create a keyboard button border style.
        ///
        /// - Parameters:
        ///   - color: The border color, by default `.clear`.
        ///   - size: The border size, by default `0`.
        public init(
            color: Color = .clear,
            size: CGFloat = 0
        ) {
            self.color = color
            self.size = size
        }
        
        /// The border color.
        public var color: Color
        
        /// The border size.
        public var size: CGFloat
    }
    
    /// This style defines the shadow of a keyboard button.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ButtonShadowStyle: Codable, Equatable {
        
        /// Create a keyboard button shadow style.
        ///
        /// - Parameters:
        ///   - color: The shadow color, by default `.keyboardButtonShadow`.
        ///   - size: The shadow size, by default `1`.
        public init(
            color: Color = .keyboardButtonShadow,
            size: CGFloat = 1
        ) {
            self.color = color
            self.size = size
        }
        
        /// The shadow color.
        public var color: Color
        
        /// The shadow size.
        public var size: CGFloat
    }
}

public extension KeyboardButton.ButtonStyle {

    /// Extend the style with another style. This will apply
    /// all non-optional properties from the provided style.
    func extended(
        with style: KeyboardButton.ButtonStyle
    ) -> Self {
        var result = self
        result.backgroundColor = style.backgroundColor ?? backgroundColor
        result.foregroundColor = style.foregroundColor ?? foregroundColor
        result.font = style.font ?? font
        result.cornerRadius = style.cornerRadius ?? cornerRadius
        result.border = style.border ?? border
        result.shadow = style.shadow ?? shadow
        return result
    }

    /// A spacer button style means that the button will not
    /// be visually detectable, but still rendered.
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

public extension KeyboardButton.ButtonBorderStyle {
    
    /// This style applies no border.
    static var noBorder = Self()
    
    /// The standard button border style.
    ///
    /// You can set this style to affect the global default.
    static var standard = Self()
}

public extension KeyboardButton.ButtonShadowStyle {
    
    /// This style applies no shadow.
    static var noShadow = Self(color: .clear)
    
    /// The standard button shadow style.
    ///
    /// You can set this style to affect the global default.
    static var standard = Self()
}

extension KeyboardButton.ButtonStyle {

    static let preview1 = Self(
        backgroundColor: .yellow,
        foregroundColor: .white,
        font: .body,
        cornerRadius: 20,
        border: .init(
            color: .red,
            size: 3
        ),
        shadow: .init(
            color: .blue,
            size: 4
        )
    )

    static let preview2 = Self(
        backgroundColor: .purple,
        foregroundColor: .yellow,
        font: .headline,
        cornerRadius: 10,
        border: .init(
            color: .blue,
            size: 5
        ),
        shadow: .init(
            color: .green,
            size: 8
        )
    )
    
    static let previewImage: KeyboardButton.ButtonStyle = {
        var style = KeyboardButton.ButtonStyle.preview1
        style.backgroundColor = .red
        #if canImport(UIKit)
        let image = UIImage(systemName: "face.smiling")
        if let data = image?.pngData() {
            style.background = .image(data: data)
            style.backgroundColor = .green
        }
        #endif
        return style
    }()
}

public extension View {

    /// Apply a ``KeyboardButton/ButtonStyle``.
    func keyboardButtonStyle(
        _ style: KeyboardButton.ButtonStyle
    ) -> some View {
        self.environment(\.keyboardButtonStyle, style)
    }
}

private extension KeyboardButton.ButtonStyle {

    struct Key: EnvironmentKey {

        /// TODO: For now, there's no standard button style.
        public static var defaultValue: KeyboardButton.ButtonStyle = .init(background: .color(.red))
    }
}

public extension EnvironmentValues {

    var keyboardButtonStyle: KeyboardButton.ButtonStyle {
        get { self [KeyboardButton.ButtonStyle.Key.self] }
        set { self [KeyboardButton.ButtonStyle.Key.self] = newValue }
    }
}
