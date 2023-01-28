//
//  SentenceAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze sentence information for strings.

 Implementing the protocol will extend the implementing type
 with functionality that builds on these `String` extensions:

 ```swift
 let string = "You are fine. You are the best."
 string.isLastSentenceEnded                         // true
 string.isLastSentenceEndedWithTrailingWhitespace   // false
 string.lastSentence                                // You are the best.
 ```

 `UITextDocumentProxy` uses this extensions to implement its
 sentence-specific extensions.

 Although you can just use the type extensions and basically
 ignore the protocol, the protocol plays together with other
 protocols and makes the functionality appear in the library
 docs, which by default omit native type extensions.
 */
public protocol SentenceAnalyzer {}

public extension SentenceAnalyzer {

    /**
     Check whether or not the last sentence in the string is
     ended, with or without trailing whitespace.
     */
    func isLastSentenceEnded(in string: String) -> Bool {
        string.isLastSentenceEnded
    }

    /**
     Check whether or not the last sentence in the string is
     ended with trailing whitespace.
     */
    func isLastSentenceEndedWithTrailingWhitespace(in string: String) -> Bool {
        string.isLastSentenceEndedWithTrailingWhitespace
    }

    /**
     Get the content of the last sentence, if any. Note that
     it will not contain the sentence delimiter.
     */
    func lastSentence(in string: String) -> String? {
        string.lastSentence
    }
}


// MARK: - String

public extension String {

    /**
     Check whether or not the last sentence in the string is
     ended, with or without trailing whitespace.
     */
    var isLastSentenceEnded: Bool {
        let content = trimming(.whitespaces).replacingOccurrences(of: "\n", with: "")
        if content.isEmpty { return true }
        let lastCharacter = String(content.suffix(1))
        return lastCharacter.isSentenceDelimiter
    }

    /**
     Check whether or not the last sentence in the string is
     ended with trailing whitespace.
     */
    var isLastSentenceEndedWithTrailingWhitespace: Bool {
        let trimmed = trimming(.whitespacesAndNewlines)
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
        let components = split(by: sentenceDelimiters).filter { !$0.isEmpty }
        let trimmed = components.last?.trimming(.whitespaces)
        let ignoreLast = trimmed?.count == 0
        return ignoreLast ? nil : components.last
    }
}
