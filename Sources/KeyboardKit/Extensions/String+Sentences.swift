//
//  String+Sentences.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /// Check if the last character is a sentence delimiter.
    var hasSentenceDelimiterSuffix: Bool {
        guard let last else { return false }
        return String(last).isSentenceDelimiter
    }

    /// Check if the last sentence is ended, with or without
    /// trailing whitespace.
    var isLastSentenceEnded: Bool {
        let content = trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\n", with: "")
        if content.isEmpty { return true }
        let lastCharacter = String(content.suffix(1))
        return lastCharacter.isSentenceDelimiter
    }

    /// Check if the last sentence is ended, with a trailing
    /// whitespace sequence.
    var isLastSentenceEndedWithTrailingWhitespace: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        if isEmpty || trimmed.isEmpty { return true }
        let lastTrimmed = String(trimmed.suffix(1))
        let isLastSpace = last?.isWhitespace == true
        let isLastNewline = last?.isNewline == true
        let isLastValid = isLastSpace || isLastNewline
        return lastTrimmed.isSentenceDelimiter && isLastValid
    }

    /// Get the trimmed content of the last sentence, if any.
    var lastSentence: String? {
        guard isLastSentenceEnded else { return nil }
        let components = split(by: Self.sentenceDelimiters).filter { !$0.isEmpty }
        let trimmed = components.last?.trimmingCharacters(in: .whitespaces)
        let ignoreLast = trimmed?.count == 0
        return ignoreLast ? nil : components.last
    }
}
