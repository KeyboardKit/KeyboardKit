//
//  AutocompleteToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to ``AutocompleteToolbar`` views.
 
 You can modify the ``standard`` style to change the default,
 global style of all ``AutocompleteToolbar``s.
 */
public struct AutocompleteToolbarStyle {
    
    /**
     Create an autocomplete toolbar style.
     
     - Parameters:
       - item: The item style, by default `.standard`.
       - separator: The separator style, by default `.standard`.
       - autocompleteBackground: The background style to apply behind autocomplete items, by default `.standard`.
     */
    public init(
        item: AutocompleteToolbarItemStyle = .standard,
        separator: AutocompleteToolbarSeparatorStyle = .standard,
        autocompleteBackground: AutocompleteToolbarItemBackgroundStyle = .standard) {
        self.item = item
        self.separator = separator
        self.autocompleteBackground = autocompleteBackground
    }
    
    /**
     The background style to apply behind autocomplete items.
     */
    public let autocompleteBackground: AutocompleteToolbarItemBackgroundStyle
    
    /**
     The item style to apply to the toolbar items.
     */
    public let item: AutocompleteToolbarItemStyle
    
    /**
     The separator style to apply to the toolbar separators.
     */
    public let separator: AutocompleteToolbarSeparatorStyle
}

public extension AutocompleteToolbarStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard = AutocompleteToolbarStyle()
}

extension AutocompleteToolbarStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = AutocompleteToolbarStyle(
        item: .preview1,
        separator: .preview1,
        autocompleteBackground: .preview1)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = AutocompleteToolbarStyle(
        item: .preview2,
        separator: .preview2,
        autocompleteBackground: .preview2)
}
