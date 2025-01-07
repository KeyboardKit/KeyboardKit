//
//  DragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/// This protocol can be implemented by any type that can be
/// used to handle drag gestures from one point to another.
public protocol DragGestureHandler {
    
    /// Handle a drag gesture from start to current location.
    func handleDragGesture(
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    )
}
