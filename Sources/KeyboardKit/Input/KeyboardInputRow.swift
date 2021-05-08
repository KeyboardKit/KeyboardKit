//
//  KeyboardInputRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This makes `KeyboardInput` conform to `RowItem`. This gives
 the arrays below extended features to modify their content.
 */
extension KeyboardInput: RowItem {

    public var rowId: KeyboardInput { self }
}

/**
 This typealias represents a list of keyboard inputs.
 */
public typealias KeyboardInputRow = [KeyboardInput]

public extension KeyboardInputRow {
    
    init(_ row: [String]) {
        self = row.map { KeyboardInput($0) }
    }
    
    func characters(for casing: KeyboardCasing = .lowercased) -> [String] {
        map { $0.character(for: casing) }
    }
}

/**
 This typealias represents a list of keyboard input rows.
 */
public typealias KeyboardInputRows = [KeyboardInputRow]

public extension KeyboardInputRows {
    
    init(_ rows: [[String]]) {
        self = rows.map { KeyboardInputRow($0) }
    }
    
    func characters(for casing: KeyboardCasing = .lowercased) -> [[String]] {
        map { $0.characters(for: casing) }
    }
}
