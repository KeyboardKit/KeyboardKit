//
//  KeyboardLayoutItemSize.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This struct provides the size of a keyboard layout item. It
 has a regular height, but a declarative width.
 */
public struct KeyboardLayoutItemSize: Equatable {
    
    public init(width: KeyboardLayoutItemWidth, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    public let width: KeyboardLayoutItemWidth
    public let height: CGFloat
}
