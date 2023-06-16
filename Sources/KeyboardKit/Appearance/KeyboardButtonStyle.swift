//
//  KeyboardButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style defines the style of a system keyboard button.

 This type has no `standard` style, since the standard style
 depends on so many factors, like button type, layout config
 etc. Instead, use a ``KeyboardAppearance``to resolve styles
 for certain actions.
 */
public struct KeyboardButtonStyle: Codable, Equatable {

    /**
     Create a system keyboard button style.

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
        border: KeyboardButtonBorderStyle? = nil,
        shadow: KeyboardButtonShadowStyle? = nil,
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

    /**
     The background color to apply to the button.
     */
    public var backgroundColor: Color?

    /**
     The border color to apply to the button.
     */
    public var foregroundColor: Color?

    /**
     The font to apply to the button.
     */
    public var font: KeyboardFont?

    /**
     The corner radius to apply to the button.
     */
    public var cornerRadius: CGFloat?

    /**
     The border color to apply to the button.
     */
    public var borderColor: Color? {
        didSet {
            guard borderColor != nil, borderSize == nil else { return }
            borderSize = 1
        }
    }

    /**
     The border size to apply to the button.
     */
    public var borderSize: CGFloat? {
        didSet {
            guard borderSize != nil, borderColor == nil else { return }
            borderColor = .black
        }
    }

    /**
     The border style to apply to the button.
     */
    public var border: KeyboardButtonBorderStyle? {
        get {
            guard let borderSize, let borderColor else { return nil }
            return .init(color: borderColor, size: borderSize)
        } set {
            borderColor = newValue?.color
            borderSize = newValue?.size
        }
    }

    /**
     The shadow color to apply to the button.
     */
    public var shadowColor: Color? {
        didSet {
            guard shadowColor != nil, shadowSize == nil else { return }
            shadowSize = 1
        }
    }

    /**
     The shadow size to apply to the button.
     */
    public var shadowSize: CGFloat? {
        didSet {
            guard shadowSize != nil, shadowColor == nil else { return }
            shadowColor = .standardButtonShadow
        }
    }

    /**
     The shadow style to apply to the button.
     */
    public var shadow: KeyboardButtonShadowStyle? {
        get {
            guard let shadowSize, let shadowColor else { return nil }
            return .init(color: shadowColor, size: shadowSize)
        } set {
            shadowColor = newValue?.color
            shadowSize = newValue?.size
        }
    }

    /**
     The color to overlay the background color when pressed.
     */
    public var pressedOverlayColor: Color?
}

public extension KeyboardButtonStyle {

    /**
     Override this style with another style. This will apply
     all non-optional properties from the provided style.
     */
    func extended(with style: KeyboardButtonStyle) -> KeyboardButtonStyle {
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
