//
//  String+Words.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /// A list of mutable, western word delimiters.
    static var wordDelimiters = "!.?,;:()[]{}<>".map(String.init) + [" ", .newline]
    
    /// Whether or not this is a western word delimiter.
    var isWordDelimiter: Bool {
        Self.wordDelimiters.contains(self)
    }
}

public extension Collection where Element == String {

    /// A list of mutable western word delimiters.
    static var wordDelimiters: [String] { String.wordDelimiters }
}

public extension String {

    /**
     Check whether or not the last character within a string
     is a word delimiter.
     */
    var hasWordDelimiterSuffix: Bool {
        String(last ?? Character("")).isWordDelimiter
    }

    /// Get the word or fragment at the start of the string.
    var wordFragmentAtStart: String {
        var reversed = String(self.reversed())
        var result = ""
        while let char = reversed.popLast() {
            guard shouldIncludeCharacterInCurrentWord(char) else { return result }
            result.append(char)
        }
        return result
    }

    /// Get the word or fragment at the end of the string.
    var wordFragmentAtEnd: String {
        var string = self
        var result = ""
        while let char = string.popLast() {
            guard shouldIncludeCharacterInCurrentWord(char) else { return result }
            result.insert(char, at: result.startIndex)
        }
        return result
    }

    /// Get the word at a certain index in the string.
    func word(at index: Int) -> String? {
        let prefix = wordFragment(before: index)
        let suffix = wordFragment(after: index)
        let result = prefix + suffix
        return result.isEmpty ? nil : result
    }

    /// Get the word fragment before a certain string index.
    func wordFragment(before index: Int) -> String {
        let splitIndex = self.index(startIndex, offsetBy: index)
        let prefix = String(prefix(upTo: splitIndex))
        return prefix.wordFragmentAtEnd
    }

    /// Get the word fragment after a certain string index.
    func wordFragment(after index: Int) -> String {
        let splitIndex = self.index(startIndex, offsetBy: index)
        let suffix = String(suffix(from: splitIndex))
        return suffix.wordFragmentAtStart
    }
}

private extension String {

    func shouldIncludeCharacterInCurrentWord(_ character: Character) -> Bool {
        !"\(character)".isWordDelimiter
    }
}
