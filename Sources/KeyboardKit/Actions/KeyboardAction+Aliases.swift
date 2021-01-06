//
//  KeyboardAction+Aliases.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a semantic representation of a list of actions.
 */
public typealias KeyboardActions = [KeyboardAction]

public extension KeyboardActions {
    
    /**
     Map a list of strings to a list of `character` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
}


/**
 This typealias represents a list of keyboard actions.
 */
public typealias KeyboardActionRow = KeyboardActions

/**
 This typealias represents a list of keyboard actions "rows".
 */
public typealias KeyboardActionRows = [KeyboardActionRow]

public extension KeyboardActionRows {
    
    /**
     Map string arrays to rows of `character` actions.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActionRow(characters: $0) }
    }
}
