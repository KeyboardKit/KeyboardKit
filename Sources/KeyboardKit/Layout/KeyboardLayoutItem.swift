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
 A keyboard layout item is used to specify an action, a size
 and edge insets for an key.
 
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
        size: Size,
        insets: EdgeInsets
    ) {
        self.action = action
        self.size = size
        self.insets = insets
    }
    
    /// The keyboard action that should be used for the item.
    public var action: KeyboardAction
    
    /// The layout size that should be used for the item.
    public var size: Size
    
    /// The item insets that should be used for the item.
    public var insets: EdgeInsets

    /// The row ID the is used to identify the item in a row.
    public var rowId: KeyboardAction { action }
}

public extension KeyboardLayoutItem {
    
    /// This is a typealias for a layout item array.
    typealias Row = [KeyboardLayoutItem]

    /// This is a typealias for a layout item row array.
    typealias Rows = [KeyboardLayoutItem.Row]
}

public extension KeyboardLayoutItem {
    
    /**
     This struct provides the size of a keyboard layout item.
     It has a regular height, but a declarative width.
     */
    struct Size: Equatable {
        
        /**
         Create a new layout item size.
         
         - Parameters:
           - width: The declarative width of the item.
           - height: The fixed height of the item.
         */
        public init(
            width: Width,
            height: CGFloat
        ) {
            self.width = width
            self.height = height
        }
        
        /// The declarative width of the item.
        public var width: Width
        
        /// The fixed height of the item.
        public var height: CGFloat
    }
    
    /**
     This enum specifies the width of a keyboard layout item,
     which is declarative and resolved at runtime.
     */
    enum Width: Equatable {
        
        /**
         Share the remaining width with other keys that also
         use `.available` on the same row.
         */
        case available
        
        /**
         Use this width type on the input keys, to later use
         it to calculate how much space other keys get.
         */
        case input
        
        /**
         Use a percentual width of the available input width.
         */
        case inputPercentage(_ percent: CGFloat)
        
        /**
         Use a percentual width of the total available width.
         */
        case percentage(_ percent: CGFloat)
        
        /**
         Use a fixed width in points.
         */
        case points(_ points: CGFloat)
    }
}
