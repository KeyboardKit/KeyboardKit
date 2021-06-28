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
        capsLocked,
        lowercased,
        uppercased,
        neutral         // TODO: Remove in KK 5.0
}

public extension KeyboardCasing {
    
    var isLowercased: Bool {
        switch self {
        case .capsLocked: return false
        case .lowercased: return true
        case .neutral: return false
        case .uppercased: return false
        }
    }
    
    var isUppercased: Bool {
        switch self {
        case .capsLocked: return true
        case .lowercased: return false
        case .neutral: return false
        case .uppercased: return true
        }
    }
}
