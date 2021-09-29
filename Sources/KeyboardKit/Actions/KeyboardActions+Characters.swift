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
     Create keyboard actions by mapping characters to a list
     of `.character` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
}

public extension KeyboardActionRows {
    
    /**
     Create keyboard action rows by mapping characters lists
     to `.character` action lists.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActions(characters: $0) }
    }
}
