//
//  KeyboardActionRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 
 This typealias represents a row of keyboard actions. It's a
 convenience abstraction.

 */
public typealias KeyboardActionRow = [KeyboardAction]


// MARK: - Public Functions

public extension KeyboardActionRow {
    
    /**
     
     Create a keyboard action row by mapping string array to
     a row of character actions.
     
     */
    static func from(_ characters: [String]) -> KeyboardActionRow {
        return characters.map { .character($0) }
    }
}
