//
//  InputSetItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct represents a keyboard input item with a neutral,
 uppercased and lowercased string.
 
 You can either create an instance with just a string, which
 is the regular way of working with input sets. However, the
 struct also supports specific casings, which means that you
 can use it to create unicode keyboards etc.
 */
public struct InputSetItem: Equatable {

    /**
     Create an input set item.

     - Parameters:
       - char: The char to use for all casings.
     */
    public init(_ char: String) {
        self.neutral = char
        self.uppercased = char.uppercased()
        self.lowercased = char.lowercased()
    }

    /**
     Create an input set item with individual char values.

     - Parameters:
       - neutral: The neutral char value.
       - uppercased: The uppercased char value.
       - lowercased: The lowercased char value.
     */
    public init(
        neutral: String,
        uppercased: String,
        lowercased: String
    ) {
        self.neutral = neutral
        self.uppercased = uppercased
        self.lowercased = lowercased
    }

    /**
     The neutral char value.
     */
    public var neutral: String

    /**
     The uppercased char value.
     */
    public var uppercased: String

    /**
     The lowercased char value.
     */
    public var lowercased: String

    /**
     Resolve the character to use for a certain case.
     */
    public func character(for case: KeyboardCase) -> String {
        switch `case` {
        case .auto: return lowercased
        case .lowercased: return lowercased
        case .uppercased, .capsLocked: return uppercased
        }
    }
}

extension InputSetItem: KeyboardRowItem {

    /**
     The row-specific ID to use when the action is presented
     in a keyboard row.
     */
    public var rowId: InputSetItem { self }
}
