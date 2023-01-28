//
//  UITextDocumentProxy+Words.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {
    
    /**
     The word that is currently being touched by the cursor.
     */
    var currentWord: String? {
        let pre = currentWordPreCursorPart
        let post = currentWordPostCursorPart
        if pre == nil && post == nil { return nil }
        return (pre ?? "") + (post ?? "")
    }
    
    /**
     The part of the current word that is before the cursor.
     */
    var currentWordPreCursorPart: String? {
        documentContextBeforeInput?.wordFragmentAtEnd
    }
    
    /**
     The part of the current word that is after the cursor.
     */
    var currentWordPostCursorPart: String? {
        documentContextAfterInput?.wordFragmentAtStart
    }
    
    /**
     Whether or not a word is currently being touched by the
     text input cursor.
     */
    var hasCurrentWord: Bool {
        currentWord != nil
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
     Whether or not the text document proxy cursor is at the
     end of the current word.
     */
    var isCursorAtTheEndOfTheCurrentWord: Bool {
        if currentWord == nil { return false }
        let postCount = currentWordPostCursorPart?.trimming(.whitespaces).count ?? 0
        if postCount > 0 { return false }
        guard let pre = currentWordPreCursorPart else { return false }
        let lastCharacter = String(pre.suffix(1))
        return !wordDelimiters.contains(lastCharacter)
    }

    /**
     The last ended word right before the cursor, if any.
     */
    var wordBeforeInput: String? {
        if isCursorAtNewSentence { return nil }
        guard isCursorAtNewWord else { return nil }
        guard let context = documentContextBeforeInput else { return nil }
        guard let result = context
            .split(by: wordDelimiters)
            .dropLast()
            .last?
            .trimming(.whitespaces)
        else { return nil }
        return result.isEmpty ? nil : result
    }

    /**
     A list of western word delimiters.

     See the ``KeyboardCharacterProvider`` documentation for
     information on how to modify this delimiter collection.
     */
    var wordDelimiters: [String] {
        String.wordDelimiters
    }
    
    /**
     Replace the current word with a replacement text.
     */
    func replaceCurrentWord(with replacement: String) {
        guard let word = currentWord else { return }
        let offset = currentWordPostCursorPart?.count ?? 0
        adjustTextPosition(byCharacterOffset: offset)
        deleteBackward(times: word.count)
        insertText(replacement)
    }
}

private extension UITextDocumentProxy {
    
    /**
     Check if a certain character should be included in the
     current word.
     */
    func shouldIncludeCharacterInCurrentWord(_ character: Character?) -> Bool {
        guard let character = character else { return false }
        return !wordDelimiters.contains("\(character)")
    }
}
#endif
