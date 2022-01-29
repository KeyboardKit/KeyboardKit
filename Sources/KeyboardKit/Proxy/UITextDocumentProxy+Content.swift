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
     beginning of a new sentence.
     */
    var isCursorAtNewSentence: Bool {
        guard let pre = trimmedDocumentContextBeforeInput?.replacingOccurrences(of: "\n", with: "") else { return true }
        if pre.isEmpty { return true }
        let lastCharacter = String(pre.suffix(1))
        return lastCharacter.isSentenceDelimiter
    }
    
    /**
     Whether or not the text document proxy cursor is at the
     beginning of a new sentence, with trailing spaces after
     the sentence delimiter.
     */
    var isCursorAtNewSentenceWithSpace: Bool {
        guard let pre = documentContextBeforeInput else { return true }
        if pre.isEmpty { return true }
        let trimmed = pre.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastTrimmed = String(trimmed.suffix(1))
        let isLastSpace = pre.last?.isWhitespace == true
        let isLastNewline = pre.last?.isNewline == true
        let isLastValid = isLastSpace || isLastNewline
        return lastTrimmed.isSentenceDelimiter && isLastValid
    }
    
    /**
     Whether or not the text document proxy cursor is at the
     beginning of a new word.
     */
    var isCursorAtNewWord: Bool {
        guard let pre = documentContextBeforeInput else { return true }
        let lastCharacter = String(pre.suffix(1))
        return pre.isEmpty || lastCharacter.isWordDelimiter
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
     The last ended word right before the cursor, if any.
     */
    var wordBeforeInput: String? {
        if isCursorAtNewSentence { return nil }
        guard isCursorAtNewWord else { return nil }
        guard let context = documentContextBeforeInput else { return nil }
        guard let result = context.split(by: wordDelimiters).dropLast().last?.trimmed() else { return nil }
        return result.isEmpty ? nil : result
    }
    
    /**
     A list of western sentence delimiters.
     */
    var sentenceDelimiters: [String] { String.sentenceDelimiters }
    
    /**
     Trimmed textual content after the text cursor.
     */
    var trimmedDocumentContextAfterInput: String? {
        documentContextAfterInput?.trimmed()
    }
    
    /**
     Trimmed textual content before the text cursor.
     */
    var trimmedDocumentContextBeforeInput: String? {
        documentContextBeforeInput?.trimmed()
    }
    
    /**
     A list of western word delimiters.
     */
    var wordDelimiters: [String] { String.wordDelimiters }
    
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


// MARK: - Private Functions

private extension String {
    
    var hasTrimmedContent: Bool {
        !trimmed().isEmpty
    }
    
    func split(by separators: [String]) -> [String] {
        let separators = CharacterSet(charactersIn: separators.joined())
        return components(separatedBy: separators)
    }
    
    func trimmed() -> String {
        trimmingCharacters(in: .whitespaces)
    }
}
#endif
