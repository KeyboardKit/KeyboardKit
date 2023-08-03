//
//  KeyboardCase.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum lists the various shift states a keyboard can use.
 */
public enum KeyboardCase: String, Codable, Identifiable {
    
    case auto
    case capsLocked
    case lowercased
    case uppercased
}

public extension KeyboardCase {
    
    /// The case's unique identifier.
    var id: String { rawValue }
    
    /// Whether or not the case is lowercased.
    var isLowercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return false
        case .lowercased: return true
        case .uppercased: return false
        }
    }
    
    /// Whether or not the case is uppercased.
    var isUppercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return true
        case .lowercased: return false
        case .uppercased: return true
        }
    }
}
