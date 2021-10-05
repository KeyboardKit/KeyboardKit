//
//  AutocompleteToolbarItemStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to `AutocompleteToolbarItem` item
 views to control the fonts and colors.
 
 You can modify the `.standard` style instance to change the
 standard, global style.
 */
public struct AutocompleteToolbarItemStyle {
    
    /**
     Create an autocomplete toolbar item style.
     
     - Parameters:
       - titleFont: The font to use for the title text, by default `.body`.
       - titleColor: The color to use for the title text, by default `.primary`.
       - subtitleFont: The font to use for the subtitle text, by default `.footnote`.
       - subtitleColor: The color to use for the subtitle text, by default `.primary`.
     */
    public init(
        titleFont: Font = .body,
        titleColor: Color = .primary,
        subtitleFont: Font = .footnote,
        subtitleColor: Color = .primary) {
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
    }
    
    /**
     The font to use for the title text.
     */
    public let titleFont: Font
    
    /**
     The color to use for the title text.
     */
    public let titleColor: Color
    
    /**
     The font to use for the subtitle text.
     */
    public let subtitleFont: Font
    
    /**
     The color to use for the subtitle text.
     */
    public let subtitleColor: Color
}

public extension AutocompleteToolbarItemStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
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
