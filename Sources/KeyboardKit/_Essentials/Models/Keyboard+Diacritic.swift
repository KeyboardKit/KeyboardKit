//
//  Keyboard+Diacritic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-05-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This type can define character diacritic variants.
    ///
    /// The ``KeyboardAction/StandardHandler`` will handle a
    /// ``KeyboardAction/diacritic(_:)`` action by replacing
    /// the last character that any diacritic match.
    struct Diacritic: Codable, Equatable {
        
        /// Create a custom diacritic value.
        ///
        /// - Parameters:
        ///   - char: The character to display.
        ///   - replacements: All possible replacements.
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
