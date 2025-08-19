//
//  UITextDocumentProxy+Sentences.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UITextDocumentProxy {

    /// Whether the proxy's input cursor is at a new line.
    var isCursorAtNewLine: Bool {
        documentContextBeforeInput?.last == "\n"
    }

    /// Whether the proxy's input cursor is at the beginning
    /// of a sentence, with or without trailing whitespaces.
    var isCursorAtNewSentence: Bool {
        documentContextBeforeInput?.isLastSentenceEnded ?? true
    }

    /// Whether the proxy's input cursor is at the beginning
    /// of a sentence, with trailing whitespaces.
    var isCursorAtNewSentenceWithTrailingWhitespace: Bool {
        documentContextBeforeInput?.isLastSentenceEndedWithTrailingWhitespace ?? true
    }

    /// The sentence just before the input cursor.
    var sentenceBeforeInput: String? {
        documentContextBeforeInput?.lastSentence
    }

    /// A list of western sentence delimiters.
    ///
    /// Set `String.sentenceDelimiters` to modify this value.
    var sentenceDelimiters: [String] {
        String.sentenceDelimiters
    }

    /// End the current sentence by removing trailing spaces,
    /// then injecting a dot and a space.
    ///
    /// - Parameters:
    ///   - text: The text to end the sentence with, by default `. `.
    func endSentence(
        withText text: String = ". "
    ) {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText(text)
    }
}
#endif
