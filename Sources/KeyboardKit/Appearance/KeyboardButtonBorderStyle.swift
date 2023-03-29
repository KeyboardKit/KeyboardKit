//
//  KeyboardButtonBorderStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the border of a keyboard button.
 
 You can modify the ``standard`` style to change the default,
 global style of all system keyboard buttons.
 */
public struct KeyboardButtonBorderStyle: Codable, Equatable {
    
    /**
     Create a system keyboard button border style.
     
     - Parameters:
       - color: The color of the border, by default `.clear`.
       - size: The size of the border, by default `0`.
     */
    public init(
        color: Color = .clear,
        size: CGFloat = 0
    ) {
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

public extension KeyboardButtonBorderStyle {
    
    /**
     This style applies no border.
     */
    static var noBorder = KeyboardButtonBorderStyle()
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = KeyboardButtonBorderStyle()
}

extension KeyboardButtonBorderStyle {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = KeyboardButtonBorderStyle(
        color: .red,
        size: 3)
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = KeyboardButtonBorderStyle(
        color: .blue,
        size: 5)
}
