//
//  SystemKeyboardButtonShadowStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the shadow of a system keyboard button.
 
 You can modify the `.standard` style instance to change the
 standard, global style.
 */
public struct SystemKeyboardButtonShadowStyle {
    
    /**
     Create a system keyboard button shadow style.
     
     - Parameters:
       - color: The color of the shadow, by default `.standardButtonShadow`.
       - size: The size of the shadow, by default 1.
     */
    public init(
        color: Color = .standardButtonShadow,
        size: CGFloat = 1) {
        self.color = color
        self.size = size
    }
    
    /**
     The color of the shadow.
     */
    public var color: Color
    
    /**
     The size of the shadow.
     */
    public var size: CGFloat
}

public extension SystemKeyboardButtonShadowStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard: SystemKeyboardButtonShadowStyle {
        SystemKeyboardButtonShadowStyle()
    }
}


extension SystemKeyboardButtonShadowStyle {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = SystemKeyboardButtonShadowStyle(
        color: .blue,
        size: 4)
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = SystemKeyboardButtonShadowStyle(
        color: .green,
        size: 8)
}
