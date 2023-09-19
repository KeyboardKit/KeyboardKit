//
//  KeyboardStyle+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-03.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI


// MARK: - Styles

public extension KeyboardStyle {
    
    /**
     This style can style ``Autocomplete/Toolbar`` views.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct AutocompleteToolbar: Codable, Equatable {
        
        /**
         Create an autocomplete toolbar style.
         
         - Parameters:
           - height: An optional toolbar height, by default `50`.
           - item: The item style, by default `.standard`.
           - separator: The separator style, by default `.standard`.
           - autocorrectBackground: The background to apply to autocorrect items, by default `.standard`.
         */
        public init(
            height: CGFloat? = 50,
            item: AutocompleteToolbarItem = .standard,
            separator: AutocompleteToolbarSeparator = .standard,
            autocorrectBackground: AutocompleteToolbarItemBackground = .standard
        ) {
            self.height = height
            self.item = item
            self.separator = separator
            self.autocorrectBackground = autocorrectBackground
        }
        
        /// The background to apply to autocorrect items.
        public var autocorrectBackground: AutocompleteToolbarItemBackground

        /// An optional, fixed toolbar height.
        public var height: CGFloat?
        
        /// The style to apply to the toolbar items.
        public var item: AutocompleteToolbarItem
        
        /// The style to apply to toolbar separators.
        public var separator: AutocompleteToolbarSeparator
    }
    
    /**
     This style can style ``Autocomplete/ToolbarItem`` views.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct AutocompleteToolbarItem: Codable, Equatable {
        
        /**
         Create an autocomplete toolbar item style.
         
         - Parameters:
           - titleFont: The font to use for the title text, by default `.body`.
           - titleColor: The color to use for the title text, by default `.primary`.
           - subtitleFont: The font to use for the subtitle text, by default `.footnote`.
           - subtitleColor: The color to use for the subtitle text, by default `.primary`.
         */
        public init(
            titleFont: KeyboardFont = .body,
            titleColor: Color = .primary,
            subtitleFont: KeyboardFont = .footnote,
            subtitleColor: Color = .primary
        ) {
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.subtitleFont = subtitleFont
            self.subtitleColor = subtitleColor
        }
        
        /// The font to use for the title text.
        public var titleFont: KeyboardFont
        
        /// The color to use for the title text.
        public var titleColor: Color
        
        /// The font to use for the subtitle text.
        public var subtitleFont: KeyboardFont
        
        /// The color to use for the subtitle text.
        public var subtitleColor: Color
    }
    
    /**
     This style can style ``Autocomplete/ToolbarItem`` views.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct AutocompleteToolbarItemBackground: Codable, Equatable {
        
        /**
         Create an autocomplete toolbar item style.
         
         - Parameters:
           - color: The background color to use, by default `.white.opacity(0.5)`.
           - cornerRadius: The corner radius to use, by default `4`.
         */
        public init(
            color: Color = .white.opacity(0.5),
            cornerRadius: CGFloat = 4
        ) {
            self.color = color
            self.cornerRadius = cornerRadius
        }
        
        /// The background color to use.
        public var color: Color
        
        /// The corner radius to use.
        public var cornerRadius: CGFloat
    }
    
    /**
     This style can style ``Autocomplete/ToolbarSeparator``s.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct AutocompleteToolbarSeparator: Codable, Equatable {
        
        /**
         Create an autocomplete toolbar separator style.
         
         - Parameters:
           - color: The color of the separator, by default `.secondary.opacity(0.5)`.
           - width: The width of the separator, by default `1`.
           - height: An height of the separator, by default `30`.
         */
        public init(
            color: Color = .secondary.opacity(0.5),
            width: CGFloat = 1,
            height: CGFloat = 30
        ) {
            self.color = color
            self.width = width
            self.height = height
        }
        
        /// The color of the separator.
        public var color: Color
        
        /// The height of the separator, it any.
        public var height: CGFloat
        
        /// The width of the separator.
        public var width: CGFloat
    }
}


// MARK: - Standard Styles

public extension KeyboardStyle.AutocompleteToolbar {
    
    /**
     This standard autocomplete toolbar style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

public extension KeyboardStyle.AutocompleteToolbarItem {
    
    /**
     This standard autocomplete item style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

public extension KeyboardStyle.AutocompleteToolbarItemBackground {
    
    /**
     This standard autocomplete item background style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

public extension KeyboardStyle.AutocompleteToolbarSeparator {
    
    /**
     This standard autocomplete separator style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}


// MARK: - Preview Styles

extension KeyboardStyle.AutocompleteToolbar {
    
    static var preview1 = Self(
        item: .preview1,
        separator: .preview1,
        autocorrectBackground: .preview1
    )
    
    static var preview2 = Self(
        item: .preview2,
        separator: .preview2,
        autocorrectBackground: .preview2
    )
}

extension KeyboardStyle.AutocompleteToolbarItem {
    
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

extension KeyboardStyle.AutocompleteToolbarItemBackground {
    
    static var preview1 = Self(
        color: .purple.opacity(0.3),
        cornerRadius: 20
    )
    
    static var preview2 = Self(
        color: .orange.opacity(0.8),
        cornerRadius: 10
    )
}

extension KeyboardStyle.AutocompleteToolbarSeparator {
    
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
