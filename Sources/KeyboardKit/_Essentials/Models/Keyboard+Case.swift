//
//  Keyboard+Case.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
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
    
    /// Whether or not the case is caps locked.
    var isCapsLocked: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: false
        }
    }
    
    /// Whether or not the case is lowercased.
    var isLowercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: false
        case .lowercased: true
        case .uppercased: false
        }
    }
    
    /// Whether or not the case is uppercased.
    var isUppercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: true
        }
    }
}

extension Keyboard.Case {
    
    var standardReleaseAction: KeyboardAction.GestureAction? {
        switch self {
        case .lowercased: { $0?.setKeyboardType(.alphabetic(.uppercased)) }
        default: { $0?.setKeyboardType(.alphabetic(.lowercased)) }
        }
    }
}
