//
//  KeyboardStyle+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style can be used to style ``InputCallout`` views.
     
     The ``calloutSize`` specifies a **minimum** size to use.
     If other factors, like button size, curve size, padding,
     etc. requires it to be larger, the size will be ignored.
     
     Note that the ``calloutSize`` height will be ignored in
     phone landscale, since callouts can't expand beyond the
     edges of a keyboard extension.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct InputCallout: Codable, Equatable {
        
        /**
         Create an input callout style.
         
         - Parameters:
           - callout: The callout style to use, by default `.standard`.
           - calloutPadding: The padding to apply to the callout content, by default `2`.
           - calloutSize: The minimum size of the callout bubble, by default `.largeTitle .light`.
           - font: The font to use in the callout.
         */
        public init(
            callout: KeyboardStyle.Callout = .standard,
            calloutPadding: CGFloat = 2,
            calloutSize: CGSize = CGSize(width: 0, height: 55),
            font: KeyboardFont = .init(.largeTitle, .light)
        ) {
            self.callout = callout
            self.calloutPadding = calloutPadding
            self.calloutSize = calloutSize
            self.font = font
        }
        
        /**
         The style to use for the callout bubble.
         */
        public var callout: KeyboardStyle.Callout
        
        /**
         The padding to apply to the callout content.
         */
        public var calloutPadding: CGFloat
        
        /**
         The minimum callout size above the button area.
         
         If other factors like button size, curve size, etc.
         requires a larger size, this value will be ignored.
         */
        public var calloutSize: CGSize
        
        /**
         The font to use in the callout.
         */
        public var font: KeyboardFont
    }
}


// MARK: - Standard Style

public extension KeyboardStyle.InputCallout {
    
    /**
     The standard input callout style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()
}
