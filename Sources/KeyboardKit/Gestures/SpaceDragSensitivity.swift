//
//  SpaceDragSensitivity.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum can be used to change the drag sensitivity of the
 spacebar. This represents how many points the spacebar must
 be dragged for the text cursor to move one step.
 */
public enum SpaceDragSensitivity {
    
    case low, medium, high, points(Int)
    
    public var points: Int {
        switch self {
        case .low: return 10
        case .medium: return 5
        case .high: return 2
        case .points(let val): return val
        }
    }
}
