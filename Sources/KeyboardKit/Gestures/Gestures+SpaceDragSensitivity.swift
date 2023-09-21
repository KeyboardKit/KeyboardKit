//
//  Gestures+SpaceDragSensitivity.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Gestures {
    
    /**
     This enum can be used to specify a sensitivity for when
     long pressing and dragging on the space key.
     
     > Note: This sensitivity corresponds to how many points
     space key must be dragged for the cursor to move a step.
     */
    enum SpaceDragSensitivity: Codable, Identifiable {
        
        case low, medium, high, custom(points: Int)
    }
}

public extension Gestures.SpaceDragSensitivity {
    
    var id: Int { points }
    
    var points: Int {
        switch self {
        case .low: return 10
        case .medium: return 5
        case .high: return 2
        case .custom(let points): return points
        }
    }
}
