//
//  KeyboardLayout+Item.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardLayout {
    
    /**
     A keyboard layout items specifies an action, a size and
     edge insets for a key on a layout-based keyboard.
     */
    struct Item: Equatable, KeyboardRowItem {
        
        /**
         Create a new layout item.
         
         - Parameters:
           - action: The keyboard action to use.
           - size: The layout size to use.
           - edgeInsets: The edge insets to apply, by default none.
         */
        public init(
            action: KeyboardAction,
            size: ItemSize,
            edgeInsets: EdgeInsets = .init()
        ) {
            self.action = action
            self.size = size
            self.edgeInsets = edgeInsets
        }
        
        /// The keyboard action to use.
        public var action: KeyboardAction
        
        /// The layout size to use.
        public var size: ItemSize
        
        /// The edge insets to apply.
        public var edgeInsets: EdgeInsets
        
        /// The row ID the is used to identify the item in a row.
        public var rowId: KeyboardAction { action }
    }
}

public extension KeyboardLayout.Item {
    
    /**
     Get the item's width in points, given a total row width
     (most often the width of the screen) and an input width.
     */
    func width(
        forRowWidth rowWidth: Double,
        inputWidth: Double
    ) -> Double? {
        let insets = edgeInsets.leading + edgeInsets.trailing
        switch size.width {
        case .available: return nil
        case .input: return inputWidth - insets
        case .inputPercentage(let percent): return percent * inputWidth - insets
        case .percentage(let percent): return percent * rowWidth - insets
        case .points(let points): return points - insets
        }
    }
}

public extension KeyboardLayout {
    
    /// This is a typealias for a layout item array.
    typealias ItemRow = [Item]

    /// This is a typealias for a layout item row array.
    typealias ItemRows = [ItemRow]
    
    /// A size with point-based height and declarative width.
    struct ItemSize: Equatable {
        
        /// Create a new layout item size.
        public init(
            width: ItemWidth,
            height: CGFloat
        ) {
            self.width = width
            self.height = height
        }
        
        /// The declarative width of the item.
        public var width: ItemWidth
        
        /// The fixed height of the item.
        public var height: CGFloat
    }
    
    /// This enum specifies various layout item width types.
    enum ItemWidth: Equatable {
        
        /// A width that will share the available row space.
        case available
        
        /// A width that should be applied to all input keys.
        case input
        
        /// A percentual width of the available input width.
        case inputPercentage(_ percent: CGFloat)
        
        /// A percentual width of the total available width.
        case percentage(_ percent: CGFloat)
        
        /// A fixed width in points.
        case points(_ points: CGFloat)
    }
}
