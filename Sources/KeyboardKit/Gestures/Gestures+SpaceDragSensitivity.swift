//
//  Gestures+SpaceDragSensitivity.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Gestures {
    
    /// This enum defines supported space drag sensitivities.
    ///
    /// The type defines to how many points a space key must
    /// be dragged for the input cursor to be moved one step.
    /// Higher sensitivity means fewer points.
    enum SpaceDragSensitivity: KeyboardModel {
        
        case low, medium, high, custom(points: Int)
    }
}

public extension Gestures.SpaceDragSensitivity {
    
    var id: Int { points }
    
    var points: Int {
        switch self {
        case .low: 10
        case .medium: 5
        case .high: 2
        case .custom(let points): points
        }
    }
}
