//
//  Keyboard+Diacritic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-05-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This struct can be used to define diacritics for any
    /// keyboard and locale.
    ///
    /// The ``KeyboardAction/StandardHandler`` will handle a
    /// ``KeyboardAction/di``
    /// that lets a keyboard automatically replace any previous
    struct Diacritic: Codable, Equatable {
        
        /// Create a custom diacritic value.
        ///
        /// - Parameters:
        ///   - char: The character to display.
        ///   - repacements: All possible replacements.
        public init(
            char: String,
            replacements: [String: String]
        ) {
            self.char = char
            self.replacements = replacements
        }
        
        /// The character to display.
        public let char: String
        
        /// All possible replacements.
        public let replacements: [String: String]
    }
}
