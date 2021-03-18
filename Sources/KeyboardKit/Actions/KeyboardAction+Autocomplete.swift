//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /**
     Whether or not the action, when triggered, should apply
     autocomplete suggestions where `isAutocomplete` is true.
     */
    var shouldApplyAutocompleteSuggestion: Bool {
        switch self {
        case .character(let char): return char.isWordDelimiter
        case .newLine: return true
        case .return: return true
        case .space: return true
        default: return false
        }
    }
}
