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
    
    public init(
        callout: CalloutStyle = .standard,
        font: Font = Self.standardFont,
        selectedBackgroundColor: Color = Color.blue,
        selectedTextColor: Color = Color.white,
        textColor: Color = .primary,
        verticalPadding: CGFloat = 5) {
        self.callout = callout
        self.font = font
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedTextColor = selectedTextColor
        self.textColor = textColor
        self.verticalPadding = verticalPadding
    }
    
    public var callout: CalloutStyle
    public var font: Font
    public var selectedBackgroundColor: Color
    public var selectedTextColor: Color
    public var textColor: Color
    public var verticalPadding: CGFloat
}

public extension SecondaryInputCalloutStyle {
    
    /**
     This is the standard style that will be used by default.
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
    
    /**
     This is the standard style for a system styled callout.
     */
    static func systemStyle(for context: KeyboardContext) -> SecondaryInputCalloutStyle {
        var style = SecondaryInputCalloutStyle.standard
        style.callout = .systemStyle(for: context)
        return style
    }
}
