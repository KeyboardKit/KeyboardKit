//
//  KeyboardInputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied to ``InputCallout``s to customize
 things like the callout style, padding, font etc.
 
 You can modify the ``standard`` style to change the default,
 global style of all ``InputCallout`` views that use it.
 
 The ``calloutSize`` specifies a **minimum** size to use for
 the callout. If other factors, like button size, curve size,
 padding etc. requires the callout to be larger, the size is
 ignored and the required size will be applied.
 
 Note that the ``calloutSize`` height will be ignored when a
 phone displays a callout in landscape, since callouts can't
 expand beyond the edges of a keyboard extension.
 */
public struct KeyboardInputCalloutStyle: Codable, Equatable {
    
    /**
     Create an input callout style.
     
     - Parameters:
       - callout: The callout style to use, by default ``KeyboardCalloutStyle/standard``.
       - calloutPadding: The padding to apply to the callout content, by default `2`.
       - calloutSize: The minimum size of the callout bubble, by default `.largeTitle .light`.
       - font: The font to use in the callout.
     */
    public init(
        callout: KeyboardCalloutStyle = .standard,
        calloutPadding: CGFloat = 2,
        calloutSize: CGSize = CGSize(width: 0, height: 55),
        font: KeyboardFont = .init(.largeTitle, .light)
    ) {
        self.callout = callout
        self.calloutPadding = calloutPadding
        self.calloutSize = calloutSize
        self.font = font
    }
    
    /**
     The callout style to use.
     */
    public var callout: KeyboardCalloutStyle
    
    /**
     The padding to apply to the callout content.
     */
    public var calloutPadding: CGFloat
    
    /**
     The minimum size of the callout above the button area.
     
     If other factors, like button size, curve size, padding
     etc. requires the callout to be larger, this is ignored.
     */
    public var calloutSize: CGSize
    
    /**
     The font to use in the callout.
     */
    public var font: KeyboardFont
}


// MARK: - Standard Style

public extension KeyboardInputCalloutStyle {
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = KeyboardInputCalloutStyle()
}
