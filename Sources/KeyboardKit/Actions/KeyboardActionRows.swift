//
//  KeyboardAction+KeyboardActionRows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a ``KeyboardActions`` array.

 The typealias makes it easier to create and handle keyboard
 action rows and collections.
 */
public typealias KeyboardActionRows = [KeyboardActions]

public extension KeyboardActionRows {
    
    /**
     Create keyboard action rows by mapping string arrays to
     a list of ``KeyboardAction/character(_:)`` actions.
    */
    init(characters: [[String]]) {
        self = characters.map { KeyboardActions(characters: $0) }
    }
}
