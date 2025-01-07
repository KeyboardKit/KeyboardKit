//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {

    /// Whether the action should apply autocorrect suggestions.
    var shouldApplyAutocorrectSuggestion: Bool {
        switch self {
        case .character(let char): char.isAutocorrectTrigger
        case .primary(let type): type.isSystemAction
        case .space: true
        default: false
        }
    }
    
    /// Whether the action should re-insert autocomplete inserted spaces.
    var shouldReinsertAutocompleteInsertedSpace: Bool {
        shouldRemoveAutocompleteInsertedSpace
    }
    
    /// Whether the action should remove autocomplete inserted spaces.
    var shouldRemoveAutocompleteInsertedSpace: Bool {
        switch self {
        case .character(let char): char.isWordDelimiter && self != .space
        default: false
        }
    }
}
