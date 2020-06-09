//
//  KeyboardActionRows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This array typealias represents a "row" of keyboard actions.
 
 This is just a semantic variation of `KeyboardActions` that
 makes it easier to talk about "rows" for certain components.
 */
public typealias KeyboardActionRow = KeyboardActions

/**
 This typealias represents a list of keyboard actions "rows".
 
 This is just a semantic variation of `KeyboardActions` that
 makes it easier to talk about "rows" for certain components.
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
