//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /**
     Whether or not the text document proxy cursor is at the
     immediate beginning of a new sentence.
     */
    var isCursorAtNewSentence: Bool {
        let content = documentContextBeforeInput?.trimmed()
        guard let pre = content?.replacingOccurrences(of: "\n", with: "") else { return true }
        if pre.isEmpty { return true }
        let lastCharacter = String(pre.suffix(1))
        return lastCharacter.isSentenceDelimiter
    }

    /**
     Whether or not the text document proxy cursor is at the
     beginning of a new sentence, with trailing spaces after
     the last sentence delimiter.
     */
    var isCursorAtNewSentenceWithSpace: Bool {
        guard let pre = documentContextBeforeInput else { return true }
        let trimmed = pre.trimmingCharacters(in: .whitespacesAndNewlines)
        if pre.isEmpty || trimmed.isEmpty { return true }
        let lastTrimmed = String(trimmed.suffix(1))
        let isLastSpace = pre.last?.isWhitespace == true
        let isLastNewline = pre.last?.isNewline == true
        let isLastValid = isLastSpace || isLastNewline
        return lastTrimmed.isSentenceDelimiter && isLastValid
    }

    /**
     The last ended sentence right before the cursor, if any.
     */
    var sentenceBeforeInput: String? {
        guard isCursorAtNewSentence else { return nil }
        guard let context = documentContextBeforeInput else { return nil }
        let components = context.split(by: sentenceDelimiters).filter { !$0.isEmpty }
        let ignoreLast = components.last?.trimmed().count == 0
        return ignoreLast ? nil : components.last
    }

    /**
     End the current sentence by removing all trailing space
     characters, then injecting a dot and a space.
     */
    func endSentence() {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText(". ")
    }
}
#endif
