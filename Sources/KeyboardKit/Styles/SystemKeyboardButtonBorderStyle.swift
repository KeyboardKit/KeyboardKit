//
//  SystemKeyboardButtonBorderStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the border of a system keyboard button.
 */
public struct SystemKeyboardButtonBorderStyle {
    
    /**
     Create a system keyboard button border style.
     
     - Parameters:
       - color: The color of the border.
       - size: The size of the border.
     */
    public init(
        color: Color,
        size: CGFloat) {
        self.color = color
        self.size = size
    }
    
    /**
     The color of the border.
     */
    public var color: Color
    
    /**
     The size of the border.
     */
    public var size: CGFloat
}

public extension SystemKeyboardButtonBorderStyle {
    
    /**
     This style means that no border should be applied. This
     is the default style for system buttons.
     */
    static var noBorder: SystemKeyboardButtonBorderStyle {
        SystemKeyboardButtonBorderStyle(color: .clear, size: 0)
    }
    
    /**
     This standard style will be used by default. It aims to
     look like the border of a native system keyboard button.
     */
    static var standard = noBorder
}
