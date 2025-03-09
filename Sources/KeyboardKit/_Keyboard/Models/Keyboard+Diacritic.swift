//
//  Keyboard+Diacritic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-05-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /// This type can be used to replace character(s) with a
    /// diacritic variant.
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
    
    /// This type describes how to apply a diacritic.
    struct DiacriticInsertionResult {
        
        /// The number of backwards deletion to apply.
        public let deleteBackwardsCount: Int
        
        /// The text to insert after deleting backwards.
        public let textInsertion: String
    }
}

public extension Keyboard.DiacriticInsertionResult {
    
    static func noMatch(for char: String) -> Keyboard.DiacriticInsertionResult {
        .init(deleteBackwardsCount: 0, textInsertion: char)
    }
}

public extension Keyboard.Diacritic {
    
    /// The sorted keys to check when performing insertions.
    var sortedReplacementKeys: [String] {
        replacements.keys.sorted { $0.count > $1.count }
    }
    
    /// Determine how the diacritic should be applied a text.
    func insertionResult(
        whenAppendedTo text: String
    ) -> Keyboard.DiacriticInsertionResult {
        for key in sortedReplacementKeys {
            if let result = insertionResult(for: text, key: key) {
                return result
            }
        }
        return .noMatch(for: char)
    }
}

private extension Keyboard.Diacritic {
    
    func insertionResult(for text: String, key: String) -> Keyboard.DiacriticInsertionResult? {
        let count = key.count
        let suffix = String(text.suffix(count))
        guard let replacement = replacements[key] else { return nil }
        guard suffix.localizedCaseInsensitiveContains(key) else { return nil }
        if suffix.isCaptalized { return .init(deleteBackwardsCount: count, textInsertion: replacement.capitalized) }
        if suffix.isUppercased { return .init(deleteBackwardsCount: count, textInsertion: replacement.uppercased()) }
        return .init(deleteBackwardsCount: count, textInsertion: replacement)
    }
}

private extension String {
    
    var isCaptalized: Bool { self == self.capitalized }
    var isUppercased: Bool { self == self.uppercased() }
}
