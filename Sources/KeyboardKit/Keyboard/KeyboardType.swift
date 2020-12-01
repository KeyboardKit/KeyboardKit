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
    
    var standardBottomKeyboardSwitcherAction: KeyboardAction? {
        switch self {
        case .alphabetic: return .keyboardType(.numeric)
        case .numeric: return .keyboardType(.alphabetic(.lowercased))
        case .symbolic: return .keyboardType(.alphabetic(.lowercased))
        default: return nil
        }
    }
    
    var standardSideKeyboardSwitcherAction: KeyboardAction? {
        switch self {
        case .alphabetic(let state): return state.standardSiderSwitchAction
        case .numeric: return .keyboardType(.symbolic)
        case .symbolic: return .keyboardType(.numeric)
        default: return nil
        }
    }
    
    /**
     Whether or not the system can change keyboard type to a
     certain type. This is just the preferred behavior given
     how the standard system behaves. You do not have to use
     this behavior if you want to.
     */
    func canBeReplaced(with type: KeyboardType) -> Bool {
        guard
            case .alphabetic(let state) = self,
            case .alphabetic(let newState) = type
            else { return true }
        if state == .capsLocked && newState == .uppercased { return false }
        return true
    }
}

private extension KeyboardShiftState {
    
    var standardSiderSwitchAction: KeyboardAction {
        isUppercased ? .shift(currentState: .uppercased) : .shift(currentState: .lowercased)
    }
}
