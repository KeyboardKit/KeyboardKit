//
//  SecondaryInputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct can be used to style `InputCallout` views.
 
 Note that the `calloutSize` width is not the total width of
 the callout, but the total size beyond the button area. The
 width is split on both sides. So the standard `26` width is
 causing the callout to go `13` points on each side.
 
 You can modify the `.standard` style instance to change the
 standard global style of all `InputCallout` views.
 */
public struct InputCalloutStyle {
    
    public init(
        callout: CalloutStyle = .standard,
        calloutSize: CGSize = CGSize(width: 26, height: 50),
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
    
    static var standard = InputCalloutStyle()
    
    static func systemStyle(for context: KeyboardContext) -> InputCalloutStyle {
        var style = InputCalloutStyle.standard
        style.callout = .systemStyle(for: context)
        return style
    }
}
