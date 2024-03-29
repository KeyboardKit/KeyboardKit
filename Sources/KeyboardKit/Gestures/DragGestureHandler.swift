//
//  KeyboardGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This protocol can be implemented by classes that can handle
 drag gestures from a start position to a current one.
 */
public protocol DragGestureHandler {
    
    /// Handle a drag gesture from start to current location.
    func handleDragGesture(
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    )
}
