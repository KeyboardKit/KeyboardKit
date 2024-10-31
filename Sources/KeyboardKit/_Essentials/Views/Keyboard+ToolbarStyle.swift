//
//  Keyboard+ToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// This style can be used to modify the visual style of
    /// the ``Keyboard/Toolbar`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/keyboardToolbarStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle {

        /// Create a custom keyboard toolbar style.
        ///
        /// - Parameters:
        ///   - backgroundColor: The toolbar color, by default `.clear`.
        ///   - minHeight: An optional fixed minimum height, by default `48`.
        public init(
            backgroundColor: Color = .clear,
            minHeight: Double = 48
        ) {
            self.backgroundColor = backgroundColor
            self.minHeight = minHeight
        }

        public var backgroundColor: Color
        public var minHeight: Double
    }
}

public extension Keyboard.ToolbarStyle {

    /// The standard keyboard toolbar style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``Keyboard/ToolbarStyle``.
    func keyboardToolbarStyle(
        _ style: Keyboard.ToolbarStyle
    ) -> some View {
        self.environment(\.keyboardToolbarStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Keyboard/ToolbarStyle``.
    @Entry var keyboardToolbarStyle = Keyboard
        .ToolbarStyle.standard
}
