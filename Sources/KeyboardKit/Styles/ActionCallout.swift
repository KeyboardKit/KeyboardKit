//
//  ActionCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to ``ActionCallout`` to customize
 things like the callout style, padding, font etc.
 
 You can modify the ``standard`` style to change the default,
 global style of all ``ActionCallout`` views that use it.
 */
public struct ActionCalloutStyle {
    
    /**
     Create a secondary input callout style.
     
     - Parameters:
       - callout: The callout style to use, by default ``CalloutStyle/standard``.
       - font: The font to use in the callout, by default ``standardFont``.
       - selectedBackgroundColor: The background color of the selected item.
       - selectedForegroundColor: The foreground color of the selected item.
       - verticalTextPadding: The vertical padding to apply to text in the callout.
     */
    public init(
        callout: CalloutStyle = .standard,
        font: Font = Self.standardFont,
        selectedBackgroundColor: Color = .blue,
        selectedForegroundColor: Color = .white,
        verticalTextPadding: CGFloat = 5) {
        self.callout = callout
        self.font = font
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedForegroundColor = selectedForegroundColor
        self.verticalTextPadding = verticalTextPadding
    }
    
    /**
     The callout style to use.
     */
    public var callout: CalloutStyle
    
    /**
     The font to use in the callout.
     */
    public var font: Font
    
    /**
     The background color of the selected item.
     */
    public var selectedBackgroundColor: Color
    
    /**
     The foreground color of the selected item.
     */
    public var selectedForegroundColor: Color
    
    /**
     The vertical padding to apply to text in the callout.
     */
    public var verticalTextPadding: CGFloat
}

public extension ActionCalloutStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard = ActionCalloutStyle()
    
    /**
     This is the standard font that will be used by default.
     */
    static var standardFont: Font {
        if #available(iOS 14.0, *) {
            return .title3
        } else {
            return .body
        }
    }
}

extension ActionCalloutStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = ActionCalloutStyle(
        callout: .preview1,
        font: .headline,
        selectedBackgroundColor: .yellow,
        selectedForegroundColor: .black,
        verticalTextPadding: 10)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = ActionCalloutStyle(
        callout: .preview2,
        font: .footnote,
        selectedBackgroundColor: .black,
        selectedForegroundColor: .yellow,
        verticalTextPadding: 15)
}
