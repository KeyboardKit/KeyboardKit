//
//  SecondaryInputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This can be used to style `SecondaryInputCallout` views, by
 applying the `secondaryInputCalloutStyle` view modifier.
 
 You can modify the `.standard` style instance to change the
 standard global style of all `SecondaryInputCallout` views.
 */
public struct SecondaryInputCalloutStyle {
    
    /**
     Create a secondary input callout style.
     
     - Parameters:
       - callout: The callout style to use.
       - font: The font to use in the callout.
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

public extension SecondaryInputCalloutStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard = SecondaryInputCalloutStyle()
    
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

extension SecondaryInputCalloutStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = SecondaryInputCalloutStyle(
        callout: .preview1,
        font: .headline,
        selectedBackgroundColor: .yellow,
        selectedForegroundColor: .black,
        verticalTextPadding: 10)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = SecondaryInputCalloutStyle(
        callout: .preview2,
        font: .footnote,
        selectedBackgroundColor: .black,
        selectedForegroundColor: .yellow,
        verticalTextPadding: 15)
}
