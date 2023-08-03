//
//  SpaceDragSensitivity.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum can be used to set the space key drag sensitivity.
 
 > Note: This sensitivity corresponds to how many points the
 space key must be dragged for the cursor to move a step.
 */
public enum SpaceDragSensitivity: Codable, Identifiable {
    
    case low, medium, high, custom(points: Int)
}

public extension SpaceDragSensitivity {
    
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
