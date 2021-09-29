//
//  KeyboardAction+Characters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-29.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardActions {
    
    /**
     Create a keyboard action list by mapping a string array
     to a list of `.character` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
}

public extension KeyboardActionRows {
    
    /**
     Map a string array to a list of `character` action rows.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActions(characters: $0) }
    }
}
