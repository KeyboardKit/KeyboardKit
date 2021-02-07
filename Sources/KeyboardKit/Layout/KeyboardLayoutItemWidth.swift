//
//  KeyboardLayoutWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This enum describes various ways in which a keyboard layout
 can size its items.
 */
public indirect enum KeyboardLayoutItemWidth: Equatable {
    
    /**
     Share any remaining width with other `.available` width
     items on the same row.
     */
    case available
    
    /**
     Use a percentual width of the total available row width.
     */
    case percentage(_ percent: CGFloat)
    
    /**
     Use a fixed width in points.
     */
    case points(_ points: CGFloat)
    
    /**
     This width is special and can be used to give all input
     items the same width. You can also use a percent of the
     input width by using the `inputPercentage` type.
     */
    case reference
    
    /**
     Use the percentual width of a `reference` item.
     */
    case useReferencePercentage(_ percent: CGFloat)
}
