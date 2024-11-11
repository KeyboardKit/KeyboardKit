//
//  Keyboard+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This style can be used to modify the visual style of
    /// the various ``Keyboard/Button`` components.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/keyboardButtonStyle(_:)``.
    ///
    /// Unlike most other styles, the style doesn't yet have
    /// a standard style, due to the complexities of how the
    /// button looks on different platforms.
    struct ButtonStyle: Codable, Equatable {
        
        /// Create a custom keyboard button style.
        ///
        /// If you provide both a keyboard font and a native
        /// one, the native one will be applied. 
        ///
        /// Note that any native fonts that are applied will
        /// be excluded from the `Codable` data.
        ///
        /// - Parameters:
        ///   - background: The background to apply, by default `nil`.
        ///   - backgroundColor: The background color to apply, by default `nil`.
        ///   - foregroundColor: The border color to apply, by default `nil`.
        ///   - font: The native font to apply, by default `nil`.
        ///   - keyboardFont: The keyboard font to apply, by default `nil`.
        ///   - cornerRadius: The corner radius to apply, by default `nil`.
        ///   - border: The border style to apply, by default `nil`.
        ///   - shadow: The shadow style to apply, by default `nil`.
        ///   - pressedOverlayColor: The color to overlay the background with when the button is pressed, by default `nil`.
        public init(
            background: Keyboard.Background? = nil,
            backgroundColor: Color? = nil,
            foregroundColor: Color? = nil,
            font: Font? = nil,
            keyboardFont: KeyboardFont? = nil,
            cornerRadius: CGFloat? = nil,
            border: BorderStyle? = nil,
            shadow: ShadowStyle? = nil,
            pressedOverlayColor: Color? = nil
        ) {
            self.background = background
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.keyboardFont = keyboardFont
            self.nativeFont = font
            self.cornerRadius = cornerRadius
            self.borderColor = border?.color
            self.borderSize = border?.size
            self.shadowColor = shadow?.color
            self.shadowSize = shadow?.size
            self.pressedOverlayColor = pressedOverlayColor
        }
        
        public typealias BorderStyle = Keyboard.ButtonBorderStyle
        public typealias ShadowStyle = Keyboard.ButtonShadowStyle
        
        /// The background style to apply to the button.
        public var background: Keyboard.Background?
        
        /// The background color to apply to the button.
        public var backgroundColor: Color?
        
        /// The border color to apply to the button.
        public var foregroundColor: Color?

        /// The font to apply to the button.
        public var font: Font? {
            keyboardFont?.font ?? nativeFont
        }

        /// The native font to apply to the button.
        public var nativeFont: Font?

        /// The keyboard font to apply to the button.
        public var keyboardFont: KeyboardFont?

        /// The corner radius to apply to the button.
        public var cornerRadius: CGFloat?

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

        /// The border color to apply to the button.
        public var borderColor: Color? {
            didSet {
                guard borderColor != nil, borderSize == nil else { return }
                borderSize = 1
            }
        }
        /// The border size to apply to the button.
        public var borderSize: CGFloat? {
            didSet {
                guard borderSize != nil, borderColor == nil else { return }
                borderColor = .black
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
        
        /// The color to apply when the button is pressed.
        public var pressedOverlayColor: Color?
    }
    
    /// This style defines the border of a keyboard button.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ButtonBorderStyle: Codable, Equatable {
        
        /// Create a custom keyboard button border style.
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
        
        /// Create a custom keyboard button shadow style.
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

public extension Keyboard.ButtonStyle {

    /// Extend the style with another style. This will apply
    /// all non-optional properties from the provided style.
    func extended(
        with style: Keyboard.ButtonStyle
    ) -> Self {
        var result = self
        result.backgroundColor = style.backgroundColor ?? backgroundColor
        result.foregroundColor = style.foregroundColor ?? foregroundColor
        result.keyboardFont = style.keyboardFont ?? keyboardFont
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

public extension Keyboard.ButtonBorderStyle {
    
    /// This style applies no border.
    static var noBorder: Self { .init() }

    /// The standard button border style.
    static var standard: Self { .noBorder }
}

public extension Keyboard.ButtonShadowStyle {
    
    /// This style applies no shadow.
    static var noShadow: Self { .init(color: .clear) }

    /// The standard button shadow style.
    static var standard: Self { .init() }
}

extension Keyboard.ButtonStyle {

    static var preview1: Self {
        .init(
            backgroundColor: .yellow,
            foregroundColor: .white,
            font: .body,
            cornerRadius: 20,
            border: .init(color: .red, size: 3),
            shadow: .init(color: .blue, size: 4),
            pressedOverlayColor: .red
        )
    }

    static var preview2: Self {
        .init(
           backgroundColor: .purple,
           foregroundColor: .yellow,
           font: .headline,
           cornerRadius: 10,
           border: .init(color: .blue, size: 5),
           shadow: .init(color: .green, size: 8),
           pressedOverlayColor: .yellow
       )
    }
    
    static let previewImage: Keyboard.ButtonStyle = {
        var style = Keyboard.ButtonStyle.preview1
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

private extension Keyboard.ButtonStyle {

    enum CodingKeys: String, CodingKey {
        case 
        background,
        backgroundColor,
        foregroundColor,
        keyboardFont,
        cornerRadius,
        borderColor,
        borderSize,
        shadowColor,
        shadowSize,
        pressedOverlayColor
    }
}

public extension View {

    /// Apply a ``Keyboard/ButtonStyle``.
    func keyboardButtonStyle(
        _ style: Keyboard.ButtonStyle
    ) -> some View {
        self.environment(\.keyboardButtonStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Keyboard/ButtonStyle``.
    @Entry var keyboardButtonStyle = Keyboard
        .ButtonStyle(background: .color(.red))
}
