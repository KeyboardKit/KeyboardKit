//
//  Keyboard+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This style can be used to modify the visual style of
    /// the various ``Keyboard/Button`` components.
    ///
    /// The ``keyboardFont`` property can be used to apply a
    /// codable font that is serialized with the rest of the
    /// style, while the optional ``font`` can be used for a
    /// non-codable, custom font that will not be serialized.
    ///
    /// You can use ``Keyboard/ButtonStyle/standard(for:context:)``
    /// or ``KeyboardAction/standardButtonStyle(for:isPressed:)``
    /// to get the standard style for any action and context.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/keyboardButtonStyle(_:)`` or with
    /// the builder-based variant.
    struct ButtonStyle: Codable, Equatable, Sendable {
        
        /// Create a custom keyboard button style.
        ///
        /// - Parameters:
        ///   - background: The background style to apply, by default `nil`.
        ///   - backgroundColor: The background color to apply, by default `nil`.
        ///   - foregroundColor: The border color to apply, by default `nil`.
        ///   - font: A custom, native font to apply, by default `nil`.
        ///   - keyboardFont: The keyboard font to apply, by default `nil`.
        ///   - cornerRadius: The corner radius to apply, by default `nil`.
        ///   - border: The border style to apply, by default `nil`.
        ///   - shadow: The shadow style to apply, by default `nil`.
        ///   - pressedOverlayColor: The overlay color to apply on press, by default `nil`.
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
            nativeFont ?? keyboardFont?.font
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
                // TODO: Remove this in KeyboardKit 10.0.
                guard borderColor != nil, borderSize == nil else { return }
                borderSize = 1
            }
        }
        /// The border size to apply to the button.
        public var borderSize: CGFloat? {
            didSet {
                // TODO: Remove this in KeyboardKit 10.0.
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
    struct ButtonBorderStyle: KeyboardModel {
        
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
    struct ButtonShadowStyle: KeyboardModel {
        
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
    
    static let previewImage: Keyboard.ButtonStyle = {
        var style = Keyboard.ButtonStyle()
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

public extension Keyboard {

    /// This type is used to customize callout actions using
    /// ``SwiftUICore/View/keyboardButtonStyle(_:)``.
    typealias ButtonStyleBuilder = (ButtonStyleBuilderParams) -> Keyboard.ButtonStyle

    /// This type is used to customize callout actions using
    /// ``SwiftUICore/View/keyboardButtonStyle(_:)``.
    struct ButtonStyleBuilderParams: KeyboardModel {

        /// Create a callout actions builder parameter value.
        public init(
            action: KeyboardAction,
        ) {
            self.action = action
        }

        /// The action to get callout actions for.
        public let action: KeyboardAction
    }
}

private extension Keyboard.ButtonStyle {

    static var unset: Self { .init(background: .color(.red)) }
}

public extension EnvironmentValues {

    /// This value can be used to apply a fixed button style.
    @Entry var keyboardButtonStyle = Keyboard.ButtonStyle.unset

    /// This value can be used to apply a fixed button style.
    ///
    /// > Note: The builder returns `nil` by default to make
    /// it possible to check if there is an injected builder.
    /// If not, the legacy service is used. The builder will
    /// replace the service in the next major version, after
    /// which this should return the standard value.
    @Entry var keyboardButtonStyleBuilder: Keyboard.ButtonStyleBuilder = { _ in .unset }
}

public extension View {

    /// Apply a fixed ``Keyboard/ButtonStyle``.
    ///
    /// This view modifier is used internally to apply style
    /// values that can vary for each key.
    func keyboardButtonStyle(
        _ style: Keyboard.ButtonStyle
    ) -> some View {
        self.environment(\.keyboardButtonStyle, style)
    }

    /// Apply a dynamic ``Keyboard/ButtonStyle`` builder.
    ///
    /// This view modifier can be applied to inject a custom
    /// style builder, to let you vary styles per action.
    func keyboardButtonStyle(
        builder: @escaping Keyboard.ButtonStyleBuilder
    ) -> some View {
        self.environment(\.keyboardButtonStyleBuilder, builder)
    }
}
