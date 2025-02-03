//
//  Keyboard+Diacritic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-05-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /// This is a typealias for the ``Diacritic`` type.
    ///
    /// > Note: This typealias is only meant to make it easy
    /// to find the ``Diacritic`` type for those who doesn't
    /// know the proper terminology.
    typealias Accent = Diacritic

    /// This type can be used to define diacritic characters,
    /// which can replace a character(s) with a combined one.
    ///
    /// The ``KeyboardAction/StandardActionHandler`` will do
    /// this by replacing any last typed, matching character.
    struct Diacritic: KeyboardModel {
        
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
