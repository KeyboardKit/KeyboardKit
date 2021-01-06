//
//  KeyboardShiftState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum lists the shift states an alphabetic keyboard can
 be in.
 */
public enum KeyboardShiftState {
    case
    lowercased,
    uppercased,
    capsLocked
}

public extension KeyboardShiftState {
    
    var isUppercased: Bool {
        switch self {
        case .lowercased: return false
        case .uppercased, .capsLocked: return true
        }
    }
}
