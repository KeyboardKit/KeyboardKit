//
//  InputSet+Item.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension InputSet {
    
    /// This struct represents an input set item, that has a
    /// neutral, uppercased and lowercased input variant.
    ///
    /// You can create an instance with just a string, which
    /// is the default way. You can however provide explicit
    /// casings, to fully customize the input characters for
    /// certain casings.
    struct Item: Equatable {
        
        /// Create an input set item with a single character.
        ///
        /// - Parameters:
        ///   - char: The char to use for all casings.
        public init(_ char: String) {
            self.neutral = char
            self.uppercased = char.uppercased()
            self.lowercased = char.lowercased()
        }
        
        /// Create an input set item with certain characters.
        ///
        /// - Parameters:
        ///   - neutral: The neutral char value.
        ///   - uppercased: The uppercased char value.
        ///   - lowercased: The lowercased char value.
        public init(
            neutral: String,
            uppercased: String,
            lowercased: String
        ) {
            self.neutral = neutral
            self.uppercased = uppercased
            self.lowercased = lowercased
        }
        
        /// The neutral char value.
        public var neutral: String
        
        /// The uppercased char value.
        public var uppercased: String
        
        /// The lowercased char value.
        public var lowercased: String
    }
}

extension InputSet.Item: KeyboardLayoutIdentifiable {

    /// The layout ID to use for the item.
    public var rowId: Self { self }
}

public extension InputSet.Item {

    /// Resolve the character to use for a certain case.
    func character(for case: Keyboard.Case) -> String {
        switch `case` {
        case .auto: lowercased
        case .lowercased: lowercased
        case .uppercased, .capsLocked: uppercased
        }
    }
}
