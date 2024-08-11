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
    /// ``SwiftUI/View/keyboardToolbarStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle {
        
        public init(
            backgroundColor: Color = .clear,
            minHeight: Double = 50
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
    static var standard = Self()
}

public extension View {

    /// Apply a ``Keyboard/ToolbarStyle``.
    func keyboardToolbarStyle(
        _ style: Keyboard.ToolbarStyle
    ) -> some View {
        self.environment(\.keyboardToolbarStyle, style)
    }
}

private extension Keyboard.ToolbarStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Keyboard.ToolbarStyle = .standard
    }
}

public extension EnvironmentValues {

    var keyboardToolbarStyle: Keyboard.ToolbarStyle {
        get { self [Keyboard.ToolbarStyle.Key.self] }
        set { self [Keyboard.ToolbarStyle.Key.self] = newValue }
    }
}
