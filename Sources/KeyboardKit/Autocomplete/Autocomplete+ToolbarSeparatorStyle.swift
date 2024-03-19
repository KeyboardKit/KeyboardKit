//
//  Autocomplete+ToolbarSeparatorStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/ToolbarSeparator`` component.
    ///
    /// You can apply this view style with the view modifier
    /// `autocompleteToolbarSeparatorStyle(_:)`.
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
    ///
    /// You can set this style to affect the global default.
    static var standard = Self()
}

extension Autocomplete.ToolbarSeparatorStyle {
    
    static var preview1 = Self(
        color: .red,
        width: 2
    )
    
    static var preview2 = Self(
        color: .green,
        width: 5,
        height: 20
    )
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarSeparatorStyle``.
    func autocompleteToolbarSeparatorStyle(
        _ style: Autocomplete.ToolbarSeparatorStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarSeparatorStyle, style)
    }
}

private extension Autocomplete.ToolbarSeparatorStyle {

    struct Key: EnvironmentKey {

        public static var defaultValue: Autocomplete.ToolbarSeparatorStyle = .standard
    }
}

public extension EnvironmentValues {

    var autocompleteToolbarSeparatorStyle: Autocomplete.ToolbarSeparatorStyle {
        get { self [Autocomplete.ToolbarSeparatorStyle.Key.self] }
        set { self [Autocomplete.ToolbarSeparatorStyle.Key.self] = newValue }
    }
}
