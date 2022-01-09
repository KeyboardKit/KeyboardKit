//
//  InputSetRows.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a list of keyboard input rows.
 */
public typealias InputSetRows = [InputSetRow]

public extension InputSetRows {
    
    /**
     Create input rows from a list of string array, that are
     mapped to a `KeyboardInputRow` array.
     */
    init(_ rows: [[String]]) {
        self = rows.map { InputSetRow($0) }
    }
    
    /**
     Create input row from lowercased and an uppercased list
     arrays, which are mapped to `KeyboardInputRow` arrays.
     
     Both arrays must contain the same amount of characters.
     */
    init(lowercased: [[String]], uppercased: [[String]]) {
        assert(lowercased.count == uppercased.count, "The lowercased and uppercased string arrays must contain the same amount of characters")
        self = lowercased.enumerated().map {
            InputSetRow(
                lowercased: lowercased[$0.offset],
                uppercased: uppercased[$0.offset])
        }
    }
    
    /**
     Get all input characters for a certain keyboard casing.
     */
    func characters(for casing: KeyboardCasing = .lowercased) -> [[String]] {
        map { $0.characters(for: casing) }
    }
}
