//
//  KeyboardAction+Rows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {

    /// This is a typealias for a keyboard action array.
    typealias Row = [KeyboardAction]
    
    /// This is a typealias for a keyboard action row array.
    typealias Rows = [KeyboardAction.Row]
}

public extension KeyboardAction.Row {

    /// Map a string's characters to a keyboard action row.
    init(characters: String) {
        self = characters.map { .character(String($0)) }
    }

    /// Map a string array to a keyboard action row.
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
    
    /// Get a matching leading character margin action.
    var leadingCharacterMarginAction: KeyboardAction {
        characterMarginAction(for: first { $0.isInputAction })
    }

    /// Get a matching character margin action.
    var trailingCharacterMarginAction: KeyboardAction {
        characterMarginAction(for: last { $0.isInputAction })
    }

    /// Get a matching character margin action for an action.
    func characterMarginAction(for action: KeyboardAction?) -> KeyboardAction {
        switch action {
        case .character(let char): .characterMargin(char)
        default: .none
        }
    }
}

public extension KeyboardAction.Rows {
    
    /// Map a string array array to keyboard action rows.
    init(characters: [[String]]) {
        self = characters.map {
            KeyboardAction.Row(characters: $0)
        }
    }
}
