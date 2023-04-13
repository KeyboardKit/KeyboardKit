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
 with functions that use public `String` extensions with the
 same names. While you can use the protocol, the main reason
 for having it is to expose these extensions to DocC.
 */
public protocol SentenceAnalyzer {}

public extension SentenceAnalyzer {

    /**
     Check whether or not the last character in the provided
     string is a sentence delimiter.
     */
    func hasSentenceDelimiterSuffix(in string: String) -> Bool {
        string.hasSentenceDelimiterSuffix
    }

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
     Check whether or not the last character within a string
     is a sentence delimiter.
     */
    var hasSentenceDelimiterSuffix: Bool {
        String(last ?? Character("")).isSentenceDelimiter
    }

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
        let components = split(by: Self.sentenceDelimiters).filter { !$0.isEmpty }
        let trimmed = components.last?.trimming(.whitespaces)
        let ignoreLast = trimmed?.count == 0
        return ignoreLast ? nil : components.last
    }
}
