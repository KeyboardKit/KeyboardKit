//
//  KeyboardActionRows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 
 This typealias represents multiple rows of keyboard actions.
 It's a convenience abstraction.
 
 */
public typealias KeyboardActionRows = [KeyboardActionRow]


// MARK: - Public Functions

public extension KeyboardActionRows {
    
    /**
     
     Create keyboard action rows by mapping string arrays to
     multiple rows character actions.
     
     */
    static func from(_ characters: [[String]]) -> KeyboardActionRows {
        return characters.map { KeyboardActionRow.from($0) }
    }
}
