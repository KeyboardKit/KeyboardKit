//
//  KeyboardLayoutItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 A keyboard layout item provides a keyboard action, the item
 size and insets. It can then be converted to a button.
 
 Note that the insets are the edge insets of each item. This
 must be applied within the button tap area, to avoid a dead
 tap area between each keyboard button.
 */
public struct KeyboardLayoutItem: Equatable {
    
    public init(
        action: KeyboardAction,
        size: Size,
        insets: EdgeInsets) {
        self.action = action
        self.size = size
        self.insets = insets
    }
    
    public let action: KeyboardAction
    public let size: Size
    public let insets: EdgeInsets
    
    /**
     This struct provides the size of a keyboard layout item.
     */
    public struct Size: Equatable {
        
        public init(width: KeyboardLayoutWidth, height: CGFloat) {
            self.width = width
            self.height = height
        }
        
        public let width: KeyboardLayoutWidth
        public let height: CGFloat
    }
}
