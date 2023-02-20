//
//  KeyboardLayoutWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-21.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This enum describes various ways in which a keyboard layout
 can size its items.
 */
public indirect enum KeyboardLayoutItemWidth: Equatable {
    
    /**
     Share the remaining width with other `.available` width
     items on the same row.
     */
    case available
    
    /**
     This width can be used to give all input items the same
     width, based on the row with the smallest input width.
     */
    case input
    
    /**
     Use a percentual width of the resulting `input` width.
     */
    case inputPercentage(_ percent: CGFloat)
    
    /**
     Use a percentual width of the total available row width.
     */
    case percentage(_ percent: CGFloat)
    
    /**
     Use a fixed width in points.
     */
    case points(_ points: CGFloat)
}
