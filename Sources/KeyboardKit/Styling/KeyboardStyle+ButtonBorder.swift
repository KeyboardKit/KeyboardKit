//
//  KeyboardStyle+ButtonBorder.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style defines the border of a keyboard button.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ButtonBorder: Codable, Equatable {
        
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
}

public extension KeyboardStyle.ButtonBorder {
    
    /**
     This style applies no border.
     */
    static var noBorder = Self()
    
    /**
     The standard button border style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}

extension KeyboardStyle.ButtonBorder {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = Self(
        color: .red,
        size: 3
    )
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = Self(
        color: .blue,
        size: 5
    )
}
