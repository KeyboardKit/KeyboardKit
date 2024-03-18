//
//  Keyboard+ToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This style can style a ``Keyboard/Toolbar``.
    ///
    /// Apply the style with `.keyboardToolbarStyle`. 
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
    ///
    /// You can set this style to affect the global default.
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

        public static var defaultValue: Keyboard.ToolbarStyle = .standard
    }
}

public extension EnvironmentValues {

    var keyboardToolbarStyle: Keyboard.ToolbarStyle {
        get { self [Keyboard.ToolbarStyle.Key.self] }
        set { self [Keyboard.ToolbarStyle.Key.self] = newValue }
    }
}
