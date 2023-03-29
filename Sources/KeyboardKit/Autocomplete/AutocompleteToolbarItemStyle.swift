//
//  AutocompleteToolbarItemStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to ``AutocompleteToolbarItem``s.
 
 You can modify the ``standard`` style to change the default,
 global style of all ``AutocompleteToolbarItem``s.
 */
public struct AutocompleteToolbarItemStyle: Codable, Equatable {
    
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
    
    /**
     The font to use for the title text.
     */
    public var titleFont: KeyboardFont
    
    /**
     The color to use for the title text.
     */
    public var titleColor: Color
    
    /**
     The font to use for the subtitle text.
     */
    public var subtitleFont: KeyboardFont
    
    /**
     The color to use for the subtitle text.
     */
    public var subtitleColor: Color
}

public extension AutocompleteToolbarItemStyle {
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = AutocompleteToolbarItemStyle()
}

extension AutocompleteToolbarItemStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = AutocompleteToolbarItemStyle(
        titleFont: .callout,
        titleColor: .red,
        subtitleFont: .body,
        subtitleColor: .yellow)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = AutocompleteToolbarItemStyle(
        titleFont: .footnote,
        titleColor: .blue,
        subtitleFont: .headline,
        subtitleColor: .purple)
}
