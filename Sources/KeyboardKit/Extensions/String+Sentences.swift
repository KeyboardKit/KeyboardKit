//
//  String+Sentences.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
 
    /// A list of known sentence delimiters.
    ///
    /// Instead of using a character set-based way to define
    /// delimiters, let's append missing ones as we find any.
    static var sentenceDelimiters = ".:!¡?¿".chars

    /// Whether or not this is a known sentence delimiters.
    var isSentenceDelimiter: Bool {
        Self.sentenceDelimiters.contains(self)
    }
}

public extension Collection where Element == String {

       /// A list of known sentence delimiters.
    static var sentenceDelimiters: [String] {
        String.sentenceDelimiters
    }
}


public extension String {

    /// Check if the last character is a sentence delimiter.
    var hasSentenceDelimiterSuffix: Bool {
        guard let last else { return false }
        return String(last).isSentenceDelimiter
    }

    /**
     Check whether or not the last sentence in the string is
     ended, with or without trailing whitespace.
     */
    var isLastSentenceEnded: Bool {
        let content = trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\n", with: "")
        if content.isEmpty { return true }
        let lastCharacter = String(content.suffix(1))
        return lastCharacter.isSentenceDelimiter
    }

    /**
     Check whether or not the last sentence in the string is
     ended with trailing whitespace.
     */
    var isLastSentenceEndedWithTrailingWhitespace: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        if isEmpty || trimmed.isEmpty { return true }
        let lastTrimmed = String(trimmed.suffix(1))
        let isLastSpace = last?.isWhitespace == true
        let isLastNewline = last?.isNewline == true
        let isLastValid = isLastSpace || isLastNewline
        return lastTrimmed.isSentenceDelimiter && isLastValid
    }

    /**
     Get the content of the last sentence, if any. Note that
     it will not contain the sentence delimiter.
     */
    var lastSentence: String? {
        guard isLastSentenceEnded else { return nil }
        let components = split(by: Self.sentenceDelimiters).filter { !$0.isEmpty }
        let trimmed = components.last?.trimmingCharacters(in: .whitespaces)
        let ignoreLast = trimmed?.count == 0
        return ignoreLast ? nil : components.last
    }
}
