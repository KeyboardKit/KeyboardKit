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
    /// ``SwiftUI/View/autocompleteToolbarStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarStyle: Codable, Equatable {
        
        /// Create an autocomplete toolbar style.
        ///
        /// - Parameters:
        ///   - height: An optional fixed height, by default `50`.
        ///   - item: The style to apply to the toolbar items, by default `.standard`.
        ///   - separator: The style to apply to autocorrect items `.standardAutocorrect`.
        ///   - autocorrectItem: The autocorrect background style, by default `.standard`.
        public init(
            height: CGFloat? = 50,
            item: Autocomplete.ToolbarItemStyle = .standard,
            autocorrectItem: Autocomplete.ToolbarItemStyle = .standardAutocorrect,
            separator: Autocomplete.ToolbarSeparatorStyle = .standard
        ) {
            self.height = height
            self.item = item
            self.autocorrectItem = autocorrectItem
            self.separator = separator
        }
        
        @available(*, deprecated, message: "Use the autocorrectItem initializer instead.")
        public init(
            height: CGFloat? = 50,
            item: Autocomplete.ToolbarItemStyle = .standard,
            separator: Autocomplete.ToolbarSeparatorStyle = .standard,
            autocorrectBackground: KeyboardStyle.AutocompleteToolbarItemBackground
        ) {
            self.height = height
            self.item = item
            self.separator = separator
            self.autocorrectItem = .init(
                backgroundColor: autocorrectBackground.color,
                backgroundCornerRadius: autocorrectBackground.cornerRadius
            )
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
    
    /// This standard autocomplete toolbar style.
    ///
    /// You can set this style to affect the global default.
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
