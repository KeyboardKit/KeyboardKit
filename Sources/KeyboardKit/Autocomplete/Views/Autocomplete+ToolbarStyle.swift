//
//  Autocomplete+ToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {

    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/Toolbar`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/autocompleteToolbarStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle: Codable, Equatable {

        /// Create a custom autocomplete toolbar style.
        ///
        /// - Parameters:
        ///   - height: An optional, fixed height, by default `48`.
        ///   - height: An optional, fixed edge padding, by default `4`.
        ///   - item: The style to apply to the toolbar items, by default `.standard`.
        ///   - separator: The style to apply to autocorrect items `.standardAutocorrect`.
        ///   - autocorrectItem: The autocorrect background style, by default `.standard`.
        public init(
            height: CGFloat = 48,
            padding: CGFloat = 4,
            item: Autocomplete.ToolbarItemStyle = .standard,
            autocorrectItem: Autocomplete.ToolbarItemStyle = .standardAutocorrect,
            separator: Autocomplete.ToolbarSeparatorStyle = .standard
        ) {
            self.height = height
            self.padding = padding
            self.item = item
            self.autocorrectItem = autocorrectItem
            self.separator = separator
        }

        /// An optional, fixed toolbar height.
        public var height: CGFloat?

        /// The toolbar's edge padding.
        public var padding: CGFloat

        /// The style to apply to the toolbar items.
        public var item: Autocomplete.ToolbarItemStyle

        /// The style to apply to autocorrect toolbar items.
        public var autocorrectItem: Autocomplete.ToolbarItemStyle

        /// The style to apply to toolbar separators.
        public var separator: Autocomplete.ToolbarSeparatorStyle
    }
}

public extension Autocomplete.ToolbarStyle {

    /// The standard autocomplete toolbar style.
    static var standard: Self { .init() }
}

extension Autocomplete.ToolbarStyle {

    static var preview1: Self {
        .init(
            item: .preview1,
            autocorrectItem: .preview2,
            separator: .preview1
        )
    }

    static var preview2: Self {
        .init(
            item: .preview2,
            autocorrectItem: .preview1,
            separator: .preview2
        )
    }
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarStyle``.
    func autocompleteToolbarStyle(
        _ style: Autocomplete.ToolbarStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Autocomplete/ToolbarStyle``.
    @Entry var autocompleteToolbarStyle = Autocomplete
        .ToolbarStyle.standard
}
