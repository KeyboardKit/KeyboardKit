//
//  CalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct can be used to style callout views, which are a
 type of view that is presented above a keyboard button.
 
 You can modify the `.standard` style instance to change the
 standard global style of all callout views.
 */
public struct CalloutStyle {
    
    public init(
        backgroundColor: Color = .standardButtonBackground,
        borderColor: Color = Color.black.opacity(0.5),
        buttonOverlayInset: CGSize = CGSize.zero,
        cornerRadius: CGFloat = 10,
        curveSize: CGSize = CGSize(width: 8, height: 15),
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 5,
        textColor: Color = .primary) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.buttonOverlayInset = buttonOverlayInset
        self.cornerRadius = cornerRadius
        self.curveSize = curveSize
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.textColor = textColor
    }
    
    public var backgroundColor: Color
    public var borderColor: Color
    public var buttonOverlayInset: CGSize
    public var cornerRadius: CGFloat
    public var curveSize: CGSize
    public var shadowColor: Color
    public var shadowRadius: CGFloat
    public var textColor: Color
}

public extension CalloutStyle {
    
    /**
     This is the standard callout style that will be used by
     default. It looks like a system keyboard callout.
     */
    static var standard = CalloutStyle()
}
