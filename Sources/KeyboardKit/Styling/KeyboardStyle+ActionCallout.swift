//
//  KeyboardStyle+ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style can be used to style ``ActionCallout`` views.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct ActionCallout: Codable, Equatable {
        
        /**
         Create an action callout style.
         
         - Parameters:
           - callout: The callout style to use, by default `.standard`.
           - font: The font to use in the callout, by default `.standardFont`.
           - maxButtonSize: The max button size, by default a `50` point square.
           - selectedBackgroundColor: The background color of the selected item, by default `.blue`.
           - selectedForegroundColor: The foreground color of the selected item, by default `.white`.
           - verticalOffset: The vertical offset of the action callout, by default `20` points on iPad devices and `0` otherwise.
           - verticalTextPadding: The vertical padding to apply to text in the callout, by default `6`.
         */
        public init(
            callout: KeyboardStyle.Callout = .standard,
            font: KeyboardFont = .init(.title3),
            maxButtonSize: CGSize = CGSize(width: 50, height: 50),
            selectedBackgroundColor: Color? = nil,
            selectedForegroundColor: Color? = nil,
            verticalOffset: CGFloat? = nil,
            verticalTextPadding: CGFloat = 6
        ) {
            self.callout = callout
            self.font = font
            self.maxButtonSize = maxButtonSize
            self.selectedBackgroundColor = selectedBackgroundColor ?? .blue
            self.selectedForegroundColor = selectedForegroundColor ?? .white
            let standardVerticalOffset: CGFloat = DeviceType.current == .pad ? 20 : 0
            self.verticalOffset = verticalOffset ?? standardVerticalOffset
            self.verticalTextPadding = verticalTextPadding
        }
        
        /**
         The style to use for the callout bubble.
         */
        public var callout: KeyboardStyle.Callout
        
        /**
         The font to use in the callout.
         */
        public var font: KeyboardFont
        
        /**
         The max size of the callout buttons.
         */
        public var maxButtonSize: CGSize
        
        /**
         The background color of the selected item.
         */
        public var selectedBackgroundColor: Color
        
        /**
         The foreground color of the selected item.
         */
        public var selectedForegroundColor: Color
        
        /**
         The vertical offset to apply to the callout.
         */
        public var verticalOffset: CGFloat
        
        /**
         The vertical padding to apply to the callout text.
         */
        public var verticalTextPadding: CGFloat
    }
}

public extension KeyboardStyle.ActionCallout {
    
    /**
     The standard action callout style.

     This can be changed to affect the global, default style.
    */
    static var standard = Self()
}
