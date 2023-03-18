//
//  AutocompleteToolbarSeparatorStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to ``AutocompleteToolbarSeparator``
 views to control the color and width of the separator line.
 
 You can modify the ``standard`` style to change the default,
 global style of all ``AutocompleteToolbarSeparator``s.
 */
public struct AutocompleteToolbarSeparatorStyle {
    
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
    
    /**
     The color of the separator.
     */
    public var color: Color
    
    /**
     The height of the separator, it any.
     */
    public var height: CGFloat
    
    /**
     The width of the separator.
     */
    public var width: CGFloat
}

public extension AutocompleteToolbarSeparatorStyle {
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = AutocompleteToolbarSeparatorStyle()
}

extension AutocompleteToolbarSeparatorStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = AutocompleteToolbarSeparatorStyle(
        color: .red,
        width: 2)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = AutocompleteToolbarSeparatorStyle(
        color: .green,
        width: 5,
        height: 20)
}
