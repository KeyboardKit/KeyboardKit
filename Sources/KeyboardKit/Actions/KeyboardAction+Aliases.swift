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

public extension Array where Element == KeyboardAction {
    
    /**
     Map a string array to a list of `character` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }
}

/**
 This typealias represents a list of keyboard actions "rows".
 */
public typealias KeyboardActionRows = [KeyboardActions]

public extension Array where Element == KeyboardActions {
    
    /**
     Map a string array to a list of `character` action rows.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActions(characters: $0) }
    }
}
