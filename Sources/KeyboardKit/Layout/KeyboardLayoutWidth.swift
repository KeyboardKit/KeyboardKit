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
public indirect enum KeyboardLayoutWidth: Equatable {
    
    /**
     Share any remaining width with other `available` layout
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
     Apply a certain width and use the result as a reference
     width that can then be used by other layout items using
     either the `useReference` or `useReferencePercentage`.
     */
    case reference(_ width: KeyboardLayoutWidth = .available)
    
    /**
     Use the width of a `reference` item.
     */
    case useReference
    
    /**
     Use the percentual width of a `reference` item.
     */
    case useReferencePercentage(_ percent: CGFloat)
}
