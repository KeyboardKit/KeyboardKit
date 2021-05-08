//
//  KeyboardAction+Aliases.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This makes `KeyboardAction` conform to `RowItem`.
 */
extension KeyboardAction: RowItem {

    public var rowId: KeyboardAction { self }
}

/**
 This typealias represents a list of keyboard actions.
 */
public typealias KeyboardActions = [KeyboardAction]

public extension KeyboardActions {
    
    /**
     Map a string array to a list of `character` actions.
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
 This typealias represents a list of keyboard action rows.
 */
public typealias KeyboardActionRows = [KeyboardActionRow]

public extension KeyboardActionRows {
    
    /**
     Map a string array to a list of `character` action rows.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActions(characters: $0) }
    }
}
