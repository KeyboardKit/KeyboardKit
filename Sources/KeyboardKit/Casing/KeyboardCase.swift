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
    
    /**
     A transient state that should automatically be replaced
     by another more appropriate case when typing.
     */
    case auto
    
    /**
     An uppercased state that shouldn't adjust automatically.
     */
    case capsLocked
    
    /**
     A shift state that should automatically shift depending
     on the text document proxy's `autocapitalization` setup.
     */
    case lowercased
    
    /**
     A shift state that should automatically shift depending
     on the text document proxy's `autocapitalization` setup.
     */
    case uppercased
}

public extension KeyboardCase {
    
    /**
     The casing's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     Whether or not the casing represents a lowercased case.
     */
    var isLowercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return false
        case .lowercased: return true
        case .uppercased: return false
        }
    }
    
    /**
     Whether or not the casing represents an uppercased case.
     */
    var isUppercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return true
        case .lowercased: return false
        case .uppercased: return true
        }
    }
}
