//
//  KeyboardStyle+ButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style defines the shadow of a keyboard button.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ButtonShadow: Codable, Equatable {
        
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
}

public extension KeyboardStyle.ButtonShadow {
    
    /**
     This style applies no shadow.
     */
    static var noShadow = Self(color: .clear)
    
    /**
     The standard button shadow style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}


extension KeyboardStyle.ButtonShadow {
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle1 = Self(
        color: .blue,
        size: 4
    )
    
    /**
     This internal style is only used in previews.
     */
    static let previewStyle2 = Self(
        color: .green,
        size: 8
    )
}
