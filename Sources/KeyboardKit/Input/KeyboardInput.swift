//
//  KeyboardInputRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct represents a keyboard input item, with an upper
 and a lowercased string.
 
 You can either create an instance with just a string, which
 is the regular way of working with input sets. However, the
 struct also supports specific casings, which means that you
 can use it to create unicode keyboards as well.
 */
public struct KeyboardInput: Equatable {
    
    public init(_ char: String) {
        self.neutral = char
        self.uppercased = char.uppercased()
        self.lowercased = char.lowercased()
    }
    
    public init(
        neutral: String,
        uppercased: String,
        lowercased: String) {
        self.neutral = neutral
        self.uppercased = uppercased
        self.lowercased = lowercased
    }
    
    var neutral: String
    var uppercased: String
    var lowercased: String
    
    func character(for casing: KeyboardCasing) -> String {
        switch casing {
        case .lowercased: return lowercased
        case .uppercased, .capsLocked: return uppercased
        case .neutral: return neutral
        }
    }
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
