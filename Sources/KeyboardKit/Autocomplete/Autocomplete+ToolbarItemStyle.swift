//
//  Autocomplete+ToolbarItemStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/ToolbarItem`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUI/View/autocompleteToolbarItemStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarItemStyle: Codable, Equatable {
        
        /// Create an autocomplete toolbar item style.
        ///
        /// - Parameters:
        ///   - titleFont: The title font to use, by default `.body`.
        ///   - titleColor: The title color to use, by default `.primary`.
        ///   - subtitleFont: The subtitle font to use, by default `.footnote`.
        ///   - subtitleColor: The subtitle color to use, by default `.primary`.
        ///   - horizontalPadding: The horizontal padding to apply, by default `4`.
        ///   - verticalPadding: The vertical padding to apply, by default `10`.
        ///   - backgroundColor: The background color to use, by default `.clear`.
        ///   - backgroundCornerRadius: The background color to use, by default `4`.
        public init(
            titleFont: KeyboardFont = .body,
            titleColor: Color = .primary,
            subtitleFont: KeyboardFont = .footnote,
            subtitleColor: Color = .primary,
            horizontalPadding: Double = 4,
            verticalPadding: Double = 10,
            backgroundColor: Color = .clear,
            backgroundCornerRadius: CGFloat = 4
        ) {
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.subtitleFont = subtitleFont
            self.subtitleColor = subtitleColor
            self.horizontalPadding = horizontalPadding
            self.verticalPadding = verticalPadding
            self.backgroundColor = backgroundColor
            self.backgroundCornerRadius = backgroundCornerRadius
        }
        
        /// The title font to use.
        public var titleFont: KeyboardFont
        
        /// The title color to use.
        public var titleColor: Color
        
        /// The subtitle font to use.
        public var subtitleFont: KeyboardFont
        
        /// The subtitle color to use.
        public var subtitleColor: Color
        
        /// The horizontal padding to apply.
        public var horizontalPadding: Double
        
        /// The vertical padding to apply.
        public var verticalPadding: Double
        
        // The background color to use.
        public var backgroundColor: Color
        
        // The background color to use.
        public var backgroundCornerRadius: CGFloat
    }
}

public extension Autocomplete.ToolbarItemStyle {
    
    /// The standard autocomplete toolbar item style.
    ///
    /// You can set this style to affect the global default.
    static var standard = Self()
    
    /// The standard autocomplete toolbar autocorrect style.
    ///
    /// You can set this style to affect the global default.
    static var standardAutocorrect = Self(
        backgroundColor: .white.opacity(0.5)
    )
}

extension Autocomplete.ToolbarItemStyle {
    
    static var preview1 = Self(
        titleFont: .callout,
        titleColor: .red,
        subtitleFont: .body,
        subtitleColor: .yellow
    )
    
    static var preview2 = Self(
        titleFont: .footnote,
        titleColor: .blue,
        subtitleFont: .headline,
        subtitleColor: .purple
    )
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarItemStyle``.
    func autocompleteToolbarItemStyle(
        _ style: Autocomplete.ToolbarItemStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarItemStyle, style)
    }
}

private extension Autocomplete.ToolbarItemStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Autocomplete.ToolbarItemStyle = .standard
    }
}

public extension EnvironmentValues {

    var autocompleteToolbarItemStyle: Autocomplete.ToolbarItemStyle {
        get { self [Autocomplete.ToolbarItemStyle.Key.self] }
        set { self [Autocomplete.ToolbarItemStyle.Key.self] = newValue }
    }
}
