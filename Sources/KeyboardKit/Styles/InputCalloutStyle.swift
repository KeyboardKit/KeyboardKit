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
    
    public init(
        callout: CalloutStyle = .standard,
        calloutSize: CGSize = CGSize(width: 65, height: 60),
        font: Font = Font.largeTitle.weight(.light)) {
        self.callout = callout
        self.calloutSize = calloutSize
        self.font = font
    }
    
    public var callout: CalloutStyle
    public var calloutSize: CGSize
    public var font: Font
}

public extension InputCalloutStyle {
    
    /**
     This is the standard callout style that will be used by
     default. It looks like a system keyboard callout.
     */
    static var standard = InputCalloutStyle()
}
