//
//  KeyboardLayoutItemSize.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This struct provides the size of a keyboard layout item. It
 has a regular height, but a declarative width.
 */
public struct KeyboardLayoutItemSize: Equatable {
    
    /**
     Create a new layout item size.
     
     - Parameters:
       - width: The declarative width of the item.
       - height: The fixed height of the item.
     */
    public init(
        width: KeyboardLayoutItemWidth,
        height: CGFloat
    ) {
        self.width = width
        self.height = height
    }
    
    /**
     The declarative width of the item.
     */
    public var width: KeyboardLayoutItemWidth
    
    /**
     The fixed height of the item.
     */
    public var height: CGFloat
}
