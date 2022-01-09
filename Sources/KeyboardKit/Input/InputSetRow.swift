//
//  InputSetRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a row of input set items.
 */
public typealias InputSetRow = [InputSetItem]

public extension InputSetRow {
    
    /**
     Create an input row from a string, where each character
     is mapped to a `InputSetItem`.
     */
    init(_ chars: String) {
        self = chars.chars.map { InputSetItem($0) }
    }
    
    /**
     Create an input row from a string array, that is mapped
     to a `InputSetItem` array.
     */
    init(_ row: [String]) {
        self = row.map { InputSetItem($0) }
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     arrays, which are mapped to a `InputSetItem` array.
     
     Both arrays must contain the same amount of characters.
     */
    init(lowercased: [String], uppercased: [String]) {
        assert(lowercased.count == uppercased.count, "The lowercased and uppercased string arrays must contain the same amount of characters")
        self = lowercased.enumerated().map {
            InputSetItem(
                neutral: lowercased[$0.offset],
                uppercased: uppercased[$0.offset],
                lowercased: lowercased[$0.offset])
        }
    }
    
    /**
     Get all input characters for a certain keyboard casing.
     */
    func characters(for casing: KeyboardCasing = .lowercased) -> [String] {
        map { $0.character(for: casing) }
    }
}
