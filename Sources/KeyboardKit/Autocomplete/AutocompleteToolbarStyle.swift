//
//  AutocompleteToolbarStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
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
       - height: An optional toolbar height, by default `50`.
       - item: The item style, by default ``AutocompleteToolbarItemStyle/standard``.
       - separator: The separator style, by default ``AutocompleteToolbarSeparatorStyle/standard``.
       - autocompleteBackground: The background style to apply behind autocomplete items, by default ``AutocompleteToolbarItemBackgroundStyle/standard``.
     */
    public init(
        height: CGFloat? = 50,
        item: AutocompleteToolbarItemStyle = .standard,
        separator: AutocompleteToolbarSeparatorStyle = .standard,
        autocompleteBackground: AutocompleteToolbarItemBackgroundStyle = .standard
    ) {
        self.height = height
        self.item = item
        self.separator = separator
        self.autocompleteBackground = autocompleteBackground
    }
    
    /**
     The background style to apply behind autocomplete items.
     */
    public var autocompleteBackground: AutocompleteToolbarItemBackgroundStyle

    /**
     An optional, fixed toolbar height.
     */
    public var height: CGFloat?
    
    /**
     The item style to apply to the toolbar items.
     */
    public var item: AutocompleteToolbarItemStyle
    
    /**
     The separator style to apply to the toolbar separators.
     */
    public var separator: AutocompleteToolbarSeparatorStyle
}

public extension AutocompleteToolbarStyle {
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
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
