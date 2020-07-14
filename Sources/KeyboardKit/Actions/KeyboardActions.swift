//
//  KeyboardActions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This array typealias represents a list of keyboard actions.
 */
public typealias KeyboardActions = [KeyboardAction]


// MARK: - Public Functions

public extension KeyboardActions {
    
    /**
     Map a list of strings to a list of `character` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
}
