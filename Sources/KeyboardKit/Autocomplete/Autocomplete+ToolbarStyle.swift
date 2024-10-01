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
        ///   - height: An optional fixed height, by default `48`.
        ///   - item: The style to apply to the toolbar items, by default `.standard`.
        ///   - separator: The style to apply to autocorrect items `.standardAutocorrect`.
        ///   - autocorrectItem: The autocorrect background style, by default `.standard`.
        public init(
            height: CGFloat? = nil,
            item: Autocomplete.ToolbarItemStyle? = nil,
            autocorrectItem: Autocomplete.ToolbarItemStyle? = nil,
            separator: Autocomplete.ToolbarSeparatorStyle? = nil
        ) {
            self.height = height ?? 48
            self.item = item ?? .standard
            self.autocorrectItem = autocorrectItem ?? .standardAutocorrect
            self.separator = separator ?? .standard
        }

        /// An optional, fixed toolbar height.
        public var height: CGFloat?

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
    static var standard = Self()
}

extension Autocomplete.ToolbarStyle {

    static var preview1 = Self(
        item: .preview1,
        autocorrectItem: .preview2,
        separator: .preview1
    )

    static var preview2 = Self(
        item: .preview2,
        autocorrectItem: .preview1,
        separator: .preview2
    )
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarStyle``.
    func autocompleteToolbarStyle(
        _ style: Autocomplete.ToolbarStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarStyle, style)
    }
}

private extension Autocomplete.ToolbarStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Autocomplete.ToolbarStyle = .standard
    }
}

public extension EnvironmentValues {

    var autocompleteToolbarStyle: Autocomplete.ToolbarStyle {
        get { self [Autocomplete.ToolbarStyle.Key.self] }
        set { self [Autocomplete.ToolbarStyle.Key.self] = newValue }
    }
}
