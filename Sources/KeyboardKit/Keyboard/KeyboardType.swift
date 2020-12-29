//
//  KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This enum contains all keyboard types that can currently be
 bound to the `KeyboardAction` switch keyboard action.
 
 If you need a keyboard type that is not represented here or
 that is app-specific, you can use `.custom`.
 */
public enum KeyboardType: Equatable {

    case
    alphabetic(_ state: KeyboardShiftState),
    numeric,
    symbolic,
    email,
    emojis,
    images,
    custom(_ name: String)
}

public extension KeyboardType {
    
    /**
     Whether or not the keyboard type is alphabetic.
     */
    var isAlphabetic: Bool {
        switch self {
        case .alphabetic: return true
        default: return false
        }
    }
    
    /**
     Whether or not the keyboard type is alphabetic and with
     a certain shift state.
     */
    func isAlphabetic(with shiftState: KeyboardShiftState) -> Bool {
        switch self {
        case .alphabetic(let state): return state == shiftState
        default: return false
        }
    }
}
