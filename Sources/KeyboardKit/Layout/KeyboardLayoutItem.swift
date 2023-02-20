//
//  KeyboardLayoutItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 Keyboard layout items are used to define a ``KeyboardAction``,
 a ``KeyboardLayoutItemSize`` and edge insets for an item in
 a system keyboard layout.
 
 Note that insets must be applied within the button tap area,
 to avoid a dead tap areas between the keyboard buttons.
 */
public struct KeyboardLayoutItem: Equatable, KeyboardRowItem {
    
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
        insets: EdgeInsets
    ) {
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

    /**
     The row ID the is used to identify the item in a row.
     */
    public var rowId: KeyboardAction { action }
}

/**
 This typealias represents a list of ``KeyboardLayoutItem``s.
 */
public typealias KeyboardLayoutItemRow = [KeyboardLayoutItem]

/**
 This typealias represents a list of ``KeyboardLayoutItemRow``
 values that make up a keyboard's rows.
 */
public typealias KeyboardLayoutItemRows = [KeyboardLayoutItemRow]
