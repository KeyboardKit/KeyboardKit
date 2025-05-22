//
//  Keyboard+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This style can be used to style a ``Keyboard/Button``.
    ///
    /// The ``keyboardFont`` property can be used to apply a
    /// codable font that is serialized with the rest of the
    /// style, while the optional ``font`` can be used for a
    /// non-codable, custom font that will not be serialized.
    ///
    /// Use the ``Keyboard/ButtonStyle/standard(for:context:isPressed:)``
    /// or ``KeyboardAction/standardButtonStyle(for:isPressed:)``
    /// functions to get a standard style for any action and
    /// keyboard context, given a specific pressed state.
    ///
    /// Apply the ``SwiftUICore/View/keyboardButtonStyle(_:)``
    /// view modifier to apply a static button style, or use
    /// the ``SwiftUICore/View/keyboardButtonStyle(builder:)``
    /// modifier to apply a dynamic, parameter-based builder.
    struct ButtonStyle: Codable, Equatable, Sendable {
        
        /// Create a custom keyboard button style.
        ///
        /// - Parameters:
        ///   - background: The background style to apply, by default `nil`.
        ///   - backgroundColor: The background color to apply, by default `nil`.
        ///   - foregroundColor: The foreground color to apply, by default `nil`.
        ///   - foregroundSecondaryOpacity: The opacity to apply to secondary titles, by default `nil`.
        ///   - font: A custom, native font to apply, by default `nil`.
        ///   - fontWeight: A weight to apply, regardless of the resolved font, by default `nil`.
        ///   - keyboardFont: The keyboard font to apply, by default `nil`.
        ///   - cornerRadius: The corner radius to apply, by default `nil`.
        ///   - border: The border style to apply, by default `nil`.
        ///   - shadow: The shadow style to apply, by default `nil`.
        ///   - contentInsets: The content insets to apply, by default `nil`.
        ///   - pressedOverlayColor: The overlay color to apply on press, by default `nil`.
        public init(
            background: Keyboard.Background? = nil,
            backgroundColor: Color? = nil,
            foregroundColor: Color? = nil,
            foregroundSecondaryOpacity: Double? = nil,
            font: Font? = nil,
            fontWeight: KeyboardFont.FontWeight? = nil,
            keyboardFont: KeyboardFont? = nil,
            cornerRadius: CGFloat? = nil,
            border: BorderStyle? = nil,
            shadow: ShadowStyle? = nil,
            contentInsets: EdgeInsets? = nil,
            pressedOverlayColor: Color? = nil
        ) {
            self.background = background
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.foregroundSecondaryOpacity = foregroundSecondaryOpacity
            self.keyboardFont = keyboardFont
            self.nativeFont = font
            self.fontWeight = fontWeight
            self.cornerRadius = cornerRadius
            self.borderColor = border?.color
            self.borderSize = border?.size
            self.shadowColor = shadow?.color
            self.shadowSize = shadow?.size
            self.contentInsets = contentInsets
            self.pressedOverlayColor = pressedOverlayColor
        }
        
        public typealias BorderStyle = Keyboard.ButtonBorderStyle
        public typealias ShadowStyle = Keyboard.ButtonShadowStyle
        
        /// The background style to apply, if any.
        public var background: Keyboard.Background?
        
        /// The background color to apply, if any.
        public var backgroundColor: Color?
        
        /// The foreground color to apply, if any.
        public var foregroundColor: Color?
        
        /// The opacity to apply to secondary titles, if any.
        public var foregroundSecondaryOpacity: Double?

        /// The font to apply, if any.
        ///
        /// This will return ``nativeFont`` if set, else the
        /// ``keyboardFont``'s computed font value.
        public var font: Font? { nativeFont ?? keyboardFont?.font }

        /// A weight to apply, regardless of the resolved font, if any.
        public var fontWeight: KeyboardFont.FontWeight?

        /// The native font to apply, if any.
        public var nativeFont: Font?

        /// The keyboard font to apply, if any.
        public var keyboardFont: KeyboardFont?

        /// The content insets to apply, if any.
        public var contentInsets: EdgeInsets?

        /// The corner radius to apply, if any.
        public var cornerRadius: CGFloat?

        /// The border style to apply, if any.
        public var border: BorderStyle? {
            get {
                guard let borderSize, let borderColor else { return nil }
                return .init(color: borderColor, size: borderSize)
            } set {
                borderColor = newValue?.color
                borderSize = newValue?.size
            }
        }

        /// The border color to apply, if any.
        public var borderColor: Color? {
            didSet {
                // TODO: Remove this in KeyboardKit 10.0.
                guard borderColor != nil, borderSize == nil else { return }
                borderSize = 1
            }
        }

        /// The border size to apply, if any.
        public var borderSize: CGFloat? {
            didSet {
                // TODO: Remove this in KeyboardKit 10.0.
                guard borderSize != nil, borderColor == nil else { return }
                borderColor = .black
            }
        }

        /// The shadow style to apply, if any.
        public var shadow: ShadowStyle? {
            get {
                guard let shadowSize, let shadowColor else { return nil }
                return .init(color: shadowColor, size: shadowSize)
            } set {
                shadowColor = newValue?.color
                shadowSize = newValue?.size
            }
        }

        /// The shadow color to apply, if any.
        public var shadowColor: Color? {
            didSet {
                guard shadowColor != nil, shadowSize == nil else { return }
                shadowSize = 1
            }
        }
        
        /// The shadow size to apply, if any.
        public var shadowSize: CGFloat? {
            didSet {
                guard shadowSize != nil, shadowColor == nil else { return }
                shadowColor = .keyboardButtonShadow
            }
        }

        /// The overlay color to apply on press, if any.
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

public extension Keyboard.ButtonStyle {

    /// Create a standard keyboard button style.
    static func standard(
        for action: KeyboardAction,
        context: KeyboardContext,
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        action.standardButtonStyle(
            for: context,
            isPressed: isPressed
        )
    }
}

public extension Keyboard.ButtonBorderStyle {
    
    /// A button border style with no borders.
    static var noBorder: Self { .init() }

    /// The standard button border style.
    static var standard: Self { .noBorder }
}

public extension Keyboard.ButtonShadowStyle {
    
    /// A button shadow style with no shadow.
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

    /// This type can be used to customize the related style
    /// with ``SwiftUICore/View/keyboardButtonStyle(builder:)``.
    typealias ButtonStyleBuilder = (ButtonStyleBuilderParams) -> Keyboard.ButtonStyle

    /// This type can be used to customize the related style
    /// with ``SwiftUICore/View/keyboardButtonStyle(builder:)``.
    struct ButtonStyleBuilderParams: KeyboardModel {

        /// Create a style builder parameter value.
        public init(
            action: KeyboardAction,
            isPressed: Bool
        ) {
            self.action = action
            self.isPressed = isPressed
        }

        /// The action to create a style for.
        public let action: KeyboardAction

        /// Whether the button is pressed.
        public let isPressed: Bool
    }
}

/// This is a temporary resolved protocol that'll be removed
/// in KeyboardKit 10.
protocol KeyboardButtonStyleResolver {

    var action: KeyboardAction { get }
    var buttonStyleBuilder: Keyboard.ButtonStyleBuilder? { get }
    var styleService: KeyboardStyleService { get }
}

extension KeyboardButtonStyleResolver {

    func keyboardButtonStyle(
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        if let builder = buttonStyleBuilder {
            return builder(.init(action: action, isPressed: isPressed))
        } else {
            return styleService.buttonStyle(for: action, isPressed: isPressed)
        }
    }
}

public extension Keyboard.ButtonStyleBuilderParams {

    /// The standard button style.
    func standardStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        action.standardButtonStyle(for: context, isPressed: isPressed)
    }
}

public extension EnvironmentValues {

    /// This value can be used to apply a fixed button style.
    ///
    /// > Note: The value returns a red button by default to
    /// make it easy to see when a style hasn't been applied.
    @Entry var keyboardButtonStyle = Keyboard.ButtonStyle(background: .color(.red))

    /// This value can be used to apply a fixed button style.
    ///
    /// > Note: The builder returns `nil` by default to make
    /// it possible to check if there is an injected builder.
    @Entry var keyboardButtonStyleBuilder: Keyboard.ButtonStyleBuilder?
}

public extension View {

    /// Apply a custom ``Keyboard/ButtonStyle``.
    func keyboardButtonStyle(
        _ style: Keyboard.ButtonStyle
    ) -> some View {
        self.environment(\.keyboardButtonStyle, style)
    }

    /// Apply a custom ``Keyboard/ButtonStyle`` builder that
    /// can customize the button style of any action.
    ///
    /// You can customize the button style of any action and
    /// use ``Keyboard/ButtonStyleBuilderParams/standardStyle(for:)``
    /// to return the standard style for all other actions.
    func keyboardButtonStyle(
        builder: @escaping Keyboard.ButtonStyleBuilder
    ) -> some View {
        self.environment(\.keyboardButtonStyleBuilder, builder)
    }
}
