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
 
 You can modify the `.standard` style instance to change the
 standard, global style.
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
     This standard style aims to mimic the native iOS style.
     */
    static var standard = SystemKeyboardButtonBorderStyle(
        color: .clear,
        size: 0)
}

extension SystemKeyboardButtonBorderStyle {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = SystemKeyboardButtonBorderStyle(
        color: .red,
        size: 3)
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = SystemKeyboardButtonBorderStyle(
        color: .blue,
        size: 5)
}
