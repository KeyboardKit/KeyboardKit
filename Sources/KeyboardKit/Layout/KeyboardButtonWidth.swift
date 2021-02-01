//
//  KeyboardButtonWidth.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This enum describes various ways in which a keyboard button
 can be sized.
 */
public indirect enum KeyboardButtonWidth {
    
    /**
     Share any remaining width with other `available` button
     views on the same row.
     */
    case available
    
    /**
     Use the width from a `reference` button.
     */
    case fromReference
    
    /**
     Use a percentual width of the total available width.
     */
    case percentage(_ percent: CGFloat)
    
    /**
     Use a fixed width in points.
     */
    case points(_ points: CGFloat)
    
    /**
     Apply a certain width and use the result as a reference
     width for other `fromReference`-sized button views.
     */
    case reference(_ width: KeyboardButtonWidth = .available)
}
