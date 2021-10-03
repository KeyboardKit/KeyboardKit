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
 */
public struct SystemKeyboardButtonShadowStyle {
    
    /**
     Create a system keyboard button shadow style.
     
     - Parameters:
       - color: The color of the shadow.
       - size: The size of the shadow.
     */
    public init(
        color: Color,
        size: CGFloat) {
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
        SystemKeyboardButtonShadowStyle(
            color: .standardButtonShadow,
            size: 1)
    }
}
