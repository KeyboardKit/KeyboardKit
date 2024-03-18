//
//  Keyboard+Toolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view can be used to render a toolbar with a min
    /// height, to ensure that callouts are not cut off.
    ///
    /// Use a `.keyboardToolbarStyle` view modifier to apply
    /// a keyboard toolbar style.
    struct Toolbar<Content: View>: View {
        
        public init(
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.content = content
        }
        
        @ViewBuilder
        private let content: () -> Content
        
        @Environment(\.keyboardToolbarStyle)
        private var style
        
        public var body: some View {
            content()
                .frame(minHeight: style.minHeight)
                .background(style.backgroundColor)
        }
    }
    
    /// This style can be used with ``Keyboard/Toolbar``.
    ///
    /// Use a `.keyboardToolbarStyle` view modifier to apply
    /// a keyboard toolbar style. 
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

#Preview {
    
    VStack {
        Keyboard.Toolbar {
            Text(".")
        }
        Color.blue
    }
    .background(Color.red)
    .keyboardToolbarStyle(.init(
        backgroundColor: Color.white.opacity(0.4),
        minHeight: 75)
    )
}

