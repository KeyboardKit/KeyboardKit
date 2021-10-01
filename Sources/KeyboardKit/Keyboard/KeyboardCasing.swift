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
 
 Note that `neutral` will be removed in KeyboardKit 5, but I
 have chosen to not mark it as such, since that would create
 a bunch of warnings within the framework.
 */
public enum KeyboardCasing: Codable {
    
    /**
     `.auto` is a transient state, that means that it should
     automatically be replaced by another case.
     */
    case auto
    
    /**
     `.capsLocked` is an uppercased state that should not be
     automatically adjusted when typing.
     */
    case capsLocked
    
    /**
     `.lowercased` should follow the `autocapitalization` of
     the text document proxy.
     */
    case lowercased
    
    /**
     `.uppercased` should follow the `autocapitalization` of
     the text document proxy.
     */
    case uppercased
    
    /// `.neutral` will be removed in 5.0 (TODO)
    case neutral
}

public extension KeyboardCasing {
    
    /**
     Whether or not the casing represents a lowercased case.
     */
    var isLowercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return false
        case .lowercased: return true
        case .neutral: return false
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
        case .neutral: return false
        case .uppercased: return true
        }
    }
}
