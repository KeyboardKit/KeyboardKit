//
//  Gestures+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension DragGestureHandler where Self == Gestures.SpaceDragGestureHandler {

    /// Create a disabled feedback service.
    static func spaceDrag(
        sensitivity: Gestures.SpaceDragSensitivity = .medium,
        verticalThreshold: Double = 50,
        action: @escaping (Int) -> Void
    ) -> Self {
        Gestures.SpaceDragGestureHandler(
            sensitivity: sensitivity,
            verticalThreshold: verticalThreshold,
            action: action
        )
    }
}
