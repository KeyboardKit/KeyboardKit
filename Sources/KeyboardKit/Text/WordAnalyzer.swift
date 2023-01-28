//
//  WordAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze word information for strings.

 Implementing the protocol will extend the implementing type
 with functionality that builds on these `String` extensions:

 ```swift
 let string = "You are fine. You are the best."
 proxy.wordFragmentAtStart
 proxy.wordFragmentAtEnd
 proxy.word(at:)
 proxy.wordFragment(before:)
 proxy.wordFragment(after:)
 ```

 `UITextDocumentProxy` uses this extensions to implement its
 word-specific extensions.

 Although you can just use the type extensions and basically
 ignore the protocol, the protocol plays together with other
 protocols and makes the functionality appear in the library
 docs, which by default omit native type extensions.
 */
public protocol WordAnalyzer {}

public extension WordAnalyzer {

    /// Get the word or fragment at the start of the string.
    func wordFragmentAtStart(in string: String) -> String {
        string.wordFragmentAtStart
    }

    /// Get the word or fragment at the end of the string.
    func wordFragmentAtEnd(in string: String) -> String {
        string.wordFragmentAtEnd
    }

    /// Get the word at a certain index in the string.
    func word(at index: Int, in string: String) -> String? {
        string.word(at: index)
    }

    /// Get the word fragment before a certain string index.
    func wordFragment(before index: Int, in string: String) -> String {
        string.wordFragment(before: index)
    }

    /// Get the word fragment after a certain string index.
    func wordFragment(after index: Int, in string: String) -> String {
        string.wordFragment(after: index)
    }
}


// MARK: - String

public extension String {

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
