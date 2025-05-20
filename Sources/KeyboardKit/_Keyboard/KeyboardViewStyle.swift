//
//  KeyboardViewStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-20.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style a ``KeyboardView``.
///
/// The static ``KeyboardViewStyle/standard`` can be used to
/// create a standard keyboard view style.
///
/// Use the ``SwiftUICore/View/keyboardViewStyle(_:)`` style
/// view modifier to apply a custom style.
public struct KeyboardViewStyle: Equatable, Sendable {

    /// Create a custom keyboard view style.
    ///
    /// You can use the ``SwiftUICore/EdgeInsets`` extension
    /// ``SwiftUICore/EdgeInsets/standardKeyboardEdgeInsets(for:)``
    /// to get standard edge insets for any keyboard context.
    ///
    /// - Parameters:
    ///   - background: The background style to apply, by default `nil`.
    ///   - foregroundColor: The foreground color to apply, by default `nil`.
    ///   - edgeInsets: The custom edge insets to apply, by default `nil`.
    public init(
        background: Keyboard.Background? = nil,
        foregroundColor: Color? = nil,
        edgeInsets: EdgeInsets? = nil
    ) {
        self.background = background
        self.foregroundColor = foregroundColor
        self.edgeInsets = edgeInsets
    }

    /// The background style to apply, if any.
    public var background: Keyboard.Background?

    /// The foreground color to apply, if any.
    public var foregroundColor: Color?

    /// The custom edge insets to apply, if any.
    public var edgeInsets: EdgeInsets?
}

public extension KeyboardViewStyle {

    /// Create a standard keyboard view style.
    static var standard: KeyboardViewStyle {
        KeyboardViewStyle(
            background: nil,
            foregroundColor: nil,
            edgeInsets: nil
        )
    }
}

public extension EnvironmentValues {

    /// This value can be used to apply a fixed button style.
    ///
    /// > Note: The builder returns `nil` by default to make
    /// it possible to check if there is an injected style.
    @Entry var keyboardViewStyle: KeyboardViewStyle?
}

public extension View {

    /// Apply a custom ``KeyboardViewStyle``.
    func keyboardViewStyle(
        _ style: KeyboardViewStyle
    ) -> some View {
        self.environment(\.keyboardViewStyle, style)
    }
}

public extension EdgeInsets {

    /// Create standard edge insets for the provided context.
    static func standardKeyboardEdgeInsets(
        for context: KeyboardContext
    ) -> EdgeInsets {
        switch context.deviceTypeForKeyboard {
        case .pad: .init(bottom: 4)
        case .phone: context.isProMaxPhone ? .zero : .init(bottom: -2)
        default: .zero
        }
    }
}

private extension KeyboardContext {

    var isProMaxPhone: Bool {
        screenSize.isEqual(to: .iPhoneProMaxScreenPortrait, withTolerance: 10)
    }
}
