//
//  SecondaryInputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This can be used to style `InputCallout` views, by applying
 the `inputCalloutStyle` view modifier.
 
 You can modify the `.standard` style instance to change the
 standard global style of all `InputCallout` views.
 */
public struct InputCalloutStyle {
    
    /**
     Create an input callout style.
     
     - Parameters:
       - callout: The callout style to use.
       - calloutSize: The size of the callout above the button area.
       - font: The font to use in the callout.
     */
    public init(
        callout: CalloutStyle = .standard,
        calloutSize: CGSize = CGSize(width: 65, height: 60),
        font: Font = Font.largeTitle.weight(.light)) {
        self.callout = callout
        self.calloutSize = calloutSize
        self.font = font
    }
    
    /**
     The callout style to use.
     */
    public var callout: CalloutStyle
    
    /**
     The size of the callout above the button area.
     */
    public var calloutSize: CGSize
    
    /**
     The font to use in the callout.
     */
    public var font: Font
}

public extension InputCalloutStyle {
    
    /**
     This standard style will be used by default. It aims to
     look like a native system keyboard's input callout.
     */
    static var standard = InputCalloutStyle()
}
