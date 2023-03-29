//
//  KeyboardButtonShadowStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the shadow of a system keyboard button.
 
 You can modify the ``standard`` style to change the default,
 global style of all system keyboard buttons.
 */
public struct KeyboardButtonShadowStyle: Codable, Equatable {
    
    /**
     Create a system keyboard button shadow style.
     
     - Parameters:
       - color: The color of the shadow, by default `.standardButtonShadow`.
       - size: The size of the shadow, by default `1`.
     */
    public init(
        color: Color = .standardButtonShadow,
        size: CGFloat = 1
    ) {
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

public extension KeyboardButtonShadowStyle {
    
    /**
     This style applies no shadow.
     */
    static var noShadow: KeyboardButtonShadowStyle {
        KeyboardButtonShadowStyle(color: .clear)
    }
    
    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = KeyboardButtonShadowStyle()
}


extension KeyboardButtonShadowStyle {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = KeyboardButtonShadowStyle(
        color: .blue,
        size: 4)
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = KeyboardButtonShadowStyle(
        color: .green,
        size: 8)
}
