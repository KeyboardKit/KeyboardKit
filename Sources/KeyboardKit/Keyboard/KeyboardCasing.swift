//
//  KeyboardCasing.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum lists the various shift states a keyboard can use.
 */
public enum KeyboardCasing {
    case
    lowercased,
    uppercased,
    capsLocked,
    neutral
}

public extension KeyboardCasing {
    
    var isLowercased: Bool {
        switch self {
        case .lowercased: return true
        case .uppercased, .capsLocked: return false
        case .neutral: return false
        }
    }
    
    var isUppercased: Bool {
        switch self {
        case .lowercased: return false
        case .uppercased, .capsLocked: return true
        case .neutral: return false
        }
    }
}
