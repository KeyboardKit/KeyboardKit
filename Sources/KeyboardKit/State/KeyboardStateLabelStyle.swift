//
//  KeyboardStateLabelStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to modify the visual style of the
/// ``KeyboardStateLabel`` component.
///
/// You can apply this view style by using the view modifier
/// ``keyboardStateLabelStyle(_:).
///
/// You can use the ``standard`` style or add your own style.
public struct KeyboardStateLabelStyle: Equatable {

    /// Create a custom label style.
    ///
    /// - Parameters:
    ///   - enabledIcon: The enabled icon style, by default `.green`.
    ///   - enabledText: The enabled text style, if any.
    ///   - disabledIcon: The disabled icon style, by default `.orange`.
    ///   - disabledText: The disabled text style, if any.
    public init(
        enabledIcon: ComponentStyle = .init(color: .green, font: nil),
        enabledText: ComponentStyle = .init(color: nil, font: nil),
        disabledIcon: ComponentStyle = .init(color: .orange, font: nil),
        disabledText: ComponentStyle = .init(color: nil, font: nil)
    ) {
        self.enabledIcon = enabledIcon
        self.enabledText = enabledText
        self.disabledIcon = disabledIcon
        self.disabledText = disabledText
    }
    
    /// This style defines the style of a label component.
    public struct ComponentStyle: Equatable {

        public init(
            color: Color?,
            font: Font?
        ) {
            self.color = color
            self.font = font
        }

        public var color: Color?
        public var font: Font?
    }

    /// The enabled icon style.
    public var enabledIcon: ComponentStyle

    /// The enabled text style.
    public var enabledText: ComponentStyle

    /// The disabled icon style.
    public var disabledIcon: ComponentStyle

    /// The disabled text style.
    public var disabledText: ComponentStyle
}

public extension KeyboardStateLabelStyle {

    /// The standard state label style.
    ///
    /// You can set this style to affect the global default.
    static var standard = KeyboardStateLabelStyle()
}

public extension View {

    /// Apply a ``KeyboardStateLabelStyle``.
    func keyboardStateLabelStyle(
        _ style: KeyboardStateLabelStyle
    ) -> some View {
        self.environment(\.keyboardStateLabelStyle, style)
    }
}

private extension KeyboardStateLabelStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: KeyboardStateLabelStyle = .standard
    }
}

public extension EnvironmentValues {

    var keyboardStateLabelStyle: KeyboardStateLabelStyle {
        get { self [KeyboardStateLabelStyle.Key.self] }
        set { self [KeyboardStateLabelStyle.Key.self] = newValue }
    }
}
