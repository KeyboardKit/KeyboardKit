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
 same name as these extensions. You can use these extensions
 directly and ignore this protocol, but the protocol exposes
 this functionality to the library documentation.

 `UITextDocumentProxy` uses the native extensions as well to
 implement its public, quotation-related functionality.
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
        let components = split(by: Self.sentenceDelimiters).filter { !$0.isEmpty }
        let trimmed = components.last?.trimming(.whitespaces)
        let ignoreLast = trimmed?.count == 0
        return ignoreLast ? nil : components.last
    }
}
