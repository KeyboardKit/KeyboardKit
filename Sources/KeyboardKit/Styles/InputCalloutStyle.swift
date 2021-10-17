//
//  InputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view style can be used to style ``InputCallout`` views.
 
 You can modify ``InputCallout/standard`` to edit the global
 style of an input callout.
 
 The ``calloutSize`` specifies a **minimum** size to use for
 the callout. If other factors, like button size, curve size,
 padding etc. requires the callout to be larger, the size is
 ignored and the required size will be applied.
 
 Note that the ``calloutSize`` height will be ignored when a
 phone displays a callout in landscape, since callouts can't
 expand beyond the edges of a keyboard extension.
 */
public struct InputCalloutStyle {
    
    /**
     Create an input callout style.
     
     - Parameters:
       - callout: The callout style to use, by default `.standard`.
       - calloutPadding: The padding to apply to the callout content.
       - calloutSize: The minimum size of the callout bubble.
       - font: The font to use in the callout.
     */
    public init(
        callout: CalloutStyle = .standard,
        calloutPadding: EdgeInsets = EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2),
        calloutSize: CGSize = CGSize(width: 0, height: 55),
        font: Font = Font.largeTitle.weight(.light)) {
        self.callout = callout
        self.calloutPadding = calloutPadding
        self.calloutSize = calloutSize
        self.font = font
    }
    
    /**
     The callout style to use.
     */
    public var callout: CalloutStyle
    
    /**
     The padding to apply to the callout content.
     */
    public var calloutPadding: EdgeInsets
    
    /**
     The minimum size of the callout above the button area.
     
     If other factors, like button size, curve size, padding
     etc. requires the callout to be larger, this is ignored.
     */
    public var calloutSize: CGSize
    
    /**
     The font to use in the callout.
     */
    public var font: Font
}

public extension InputCalloutStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard = InputCalloutStyle()
}

extension InputCalloutStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = InputCalloutStyle(
        callout: .preview1,
        calloutSize: CGSize(width: 0, height: 40),
        font: .body)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = InputCalloutStyle(
        callout: .preview2,
        calloutPadding: EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40),
        calloutSize: CGSize(width: 100, height: 60),
        font: .footnote)
}
