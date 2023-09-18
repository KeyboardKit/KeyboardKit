//
//  Keyboard+Case.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines various keyboard shift states.
    enum Case: String, Codable, Identifiable {
        
        case auto
        case capsLocked
        case lowercased
        case uppercased
    }
}

public extension Keyboard.Case {
    
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
