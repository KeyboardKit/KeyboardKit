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
    /// You can style this component with the style modifier
    /// ``keyboardToolbarStyle(_:)``.
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
                .frame(maxWidth: .infinity)
                .frame(height: style.height)
                .frame(minHeight: style.minHeight, maxHeight: style.maxHeight)
                .background(style.backgroundColor)
        }
    }

    /// This style can be used to modify the visual style of
    /// the ``Keyboard/Toolbar`` component.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle {

        /// Create a custom keyboard toolbar style.
        ///
        /// - Parameters:
        ///   - backgroundColor: The toolbar color, by default `.clear`.
        ///   - height: An optional fixed height, by default `nil`..
        ///   - minHeight: The toolbar's minimum height, by default `48`.
        ///   - maxHeight: An optional max height, by default `nil`.
        public init(
            backgroundColor: Color = .clear,
            height: CGFloat? = nil,
            minHeight: Double = 48,
            maxHeight: CGFloat? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.height = height
            self.minHeight = minHeight
            self.maxHeight = maxHeight
        }

        /// The toolbar's background color.
        public var backgroundColor: Color

        /// An optional fixed height.
        public var height: CGFloat?

        /// The toolbar's minimum height.
        public var minHeight: Double

        /// An optional max height.
        public var maxHeight: CGFloat?
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


#Preview {
    
    VStack(spacing: 0) {
        Color.blue
        Keyboard.Toolbar {
            VStack {
                Text(".")
            }
        }
        Color.blue
    }
    .background(Color.keyboardBackground)
    .keyboardToolbarStyle(.init(
        height: 350
    ))
}
