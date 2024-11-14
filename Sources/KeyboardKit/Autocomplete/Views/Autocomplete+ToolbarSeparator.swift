//
//  Autocomplete+ToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view mimics a native autocomplete separator.
    ///
    /// You can style this component with the style modifier
    /// ``autocompleteToolbarSeparatorStyle(_:)``.
    struct ToolbarSeparator: View {
        
        /// Create an autocomplete toolbar item separator.
        public init() {}
        
        @Environment(\.autocompleteToolbarSeparatorStyle)
        private var style

        private typealias Style = Autocomplete.ToolbarSeparatorStyle

        public var body: some View {
            style.color
                .frame(width: style.width)
                .frame(height: style.height)
        }
    }

    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/ToolbarSeparator`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/autocompleteToolbarSeparatorStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarSeparatorStyle: Codable, Equatable {

        /// Create a custom toolbar separator style.
        ///
        /// - Parameters:
        ///   - color: The separator color, by default `.secondary.opacity(0.5)`.
        ///   - width: The separator width, by default `1`.
        ///   - height: The separator height, by default `30`.
        public init(
            color: Color = .secondary.opacity(0.5),
            width: CGFloat = 1,
            height: CGFloat = 30
        ) {
            self.color = color
            self.width = width
            self.height = height
        }

        /// The separator color.
        public var color: Color

        /// The separator width.
        public var height: CGFloat

        /// The separator height.
        public var width: CGFloat
    }
}

public extension Autocomplete.ToolbarSeparatorStyle {

    /// The standard autocomplete toolbar separator style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarSeparatorStyle``.
    func autocompleteToolbarSeparatorStyle(
        _ style: Autocomplete.ToolbarSeparatorStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarSeparatorStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Autocomplete/ToolbarSeparatorStyle``.
    @Entry var autocompleteToolbarSeparatorStyle = Autocomplete
        .ToolbarSeparatorStyle.standard
}

#Preview {
    
    HStack {
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(.standard)
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(
                .init(color: .blue, width: 10)
            )
        Autocomplete.ToolbarSeparator()
            .autocompleteToolbarSeparatorStyle(
                .init(color: .yellow, width: 5)
            )
    }
    .padding()
    .background(Color.keyboardBackground)
}
