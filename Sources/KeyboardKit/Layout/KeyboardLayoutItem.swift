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
    
    /**
     Create a new layout item.
     
     - Parameters:
       - action: The keyboard action that should be used for the item.
       - size: The layout size that should be used for the item.
       - insets: The item insets that should be used for the item.
     */
    public init(
        action: KeyboardAction,
        size: KeyboardLayoutItemSize,
        insets: EdgeInsets) {
        self.action = action
        self.size = size
        self.insets = insets
    }
    
    /**
     The keyboard action that should be used for the item.
     */
    public var action: KeyboardAction
    
    /**
     The layout size that should be used for the item.
     */
    public var size: KeyboardLayoutItemSize
    
    /**
     The item insets that should be used for the item.
     */
    public var insets: EdgeInsets
}
