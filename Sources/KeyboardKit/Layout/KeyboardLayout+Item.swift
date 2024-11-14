//
//  KeyboardLayout+Item.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardLayout {
    
    /// A keyboard layout items defines an action, size, and
    /// optional insets for a key on a layout-based keyboard.
    struct Item: Equatable {
        
        /// Create a new layout item.
        ///
        /// - Parameters:
        ///   - action: The keyboard action to use.
        ///   - size: The layout size to use.
        ///   - alignment: The content alignment, by default `.center`.
        ///   - edgeInsets: The edge insets to apply, by default none.
        public init(
            action: KeyboardAction,
            size: ItemSize,
            alignment: Alignment = .center,
            edgeInsets: EdgeInsets = .init()
        ) {
            self.action = action
            self.size = size
            self.alignment = alignment
            self.edgeInsets = edgeInsets
        }
        
        /// The keyboard action to use.
        public var action: KeyboardAction
        
        /// The layout size to use.
        public var size: ItemSize
        
        /// The content alignment to apply.
        public var alignment: Alignment
        
        /// The edge insets to apply.
        public var edgeInsets: EdgeInsets
    }

    /// This typealias represents a list of layout items.
    typealias ItemRow = [Item]

    /// This typealias represents a list of layout item rows.
    typealias ItemRows = [ItemRow]
}

public extension KeyboardLayout.Item {
    
    /// Create a copy by replacing the item keyboard action.
    func copy(
        withAction action: KeyboardAction
    ) -> Self {
        var result = self
        result.action = action
        return result
    }
    
    /// Get an item width in points, given a total row width
    /// (most often the screen width) and an input width.
    func width(
        forRowWidth rowWidth: Double,
        inputWidth: Double
    ) -> Double? {
        width(
            forRowWidth: rowWidth,
            inputWidth: inputWidth,
            edgeInsets: edgeInsets.leading + edgeInsets.trailing
        )
    }
    
    /// Get an item width in points, given a total row width
    /// (most often screen width), input width and insets.
    func width(
        forRowWidth rowWidth: Double,
        inputWidth: Double,
        edgeInsets insets: Double
    ) -> Double? {
        switch size.width {
        case .available: nil
        case .input: inputWidth - insets
        case .inputPercentage(let percent): percent * inputWidth - insets
        case .percentage(let percent): percent * rowWidth - insets
        case .points(let points): points - insets
        }
    }
}

public extension KeyboardLayout {
    
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

public extension KeyboardLayout {
    
    /// Get the layout item with a certain action, if any.
    func firstCharacterItem() -> Item? {
        itemRows.compactMap { row in
            row.first { $0.action.isCharacterAction }
        }.first
    }
    
    /// Get the layout item with a certain action, if any.
    func firstItem(
        with action: KeyboardAction
    ) -> Item? {
        itemRows.compactMap { row in
            row.first { $0.action == action }
        }.first
    }
}
