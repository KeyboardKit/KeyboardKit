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
public enum KeyboardCasing {
    case
        
        /// `.auto` is a transient state, that means that it
        /// should automatically be replaced by another case
        /// that is contextually correct.
        auto,
        
        /// `.capsLocked` is an uppercased state that should
        /// not be adjusted when typing.
        capsLocked,
        
        /// `.lowercased` should conform to the text proxy's
        /// autocapitalization type.
        lowercased,
        
        /// `.uppercased` should conform to the text proxy's
        /// autocapitalization type.
        uppercased,
        
        /// `.neutral` will be removed in 5.0 (TODO)
        neutral
}

public extension KeyboardCasing {
    
    var isLowercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return false
        case .lowercased: return true
        case .neutral: return false
        case .uppercased: return false
        }
    }
    
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
