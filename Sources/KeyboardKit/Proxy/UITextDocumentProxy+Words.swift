//
//  UITextDocumentProxy+Words.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UITextDocumentProxy {
    
    /// The word at the cursor location, if any.
    var currentWord: String? {
        let pre = currentWordPreCursorPart
        let post = currentWordPostCursorPart
        if pre == nil && post == nil { return nil }
        return (pre ?? "") + (post ?? "")
    }
    
    /// The word segment before the cursor location, if any.
    var currentWordPreCursorPart: String? {
        documentContextBeforeInput?.wordFragmentAtEnd
    }
    
    /// The word segment after the cursor location, if any.
    var currentWordPostCursorPart: String? {
        documentContextAfterInput?.wordFragmentAtStart
    }
    
    /// Whether the proxy has a current word.
    var hasCurrentWord: Bool {
        currentWord != nil
    }

    /// Whether the cursor is at the beginning of a word.
    var isCursorAtNewWord: Bool {
        guard let pre = documentContextBeforeInput else { return true }
        let lastCharacter = String(pre.suffix(1))
        return pre.isEmpty || lastCharacter.isWordDelimiter
    }

    /// Whether the cursor is at the end of the current word.
    var isCursorAtTheEndOfTheCurrentWord: Bool {
        if currentWord == nil { return false }
        let postCount = currentWordPostCursorPart?.trimmingCharacters(in: .whitespaces).count ?? 0
        if postCount > 0 { return false }
        guard let pre = currentWordPreCursorPart else { return false }
        let lastCharacter = String(pre.suffix(1))
        return !wordDelimiters.contains(lastCharacter)
    }

    /// The last ended word right before the cursor, if any.
    var wordBeforeInput: String? {
        if isCursorAtNewSentence { return nil }
        guard isCursorAtNewWord else { return nil }
        guard let context = documentContextBeforeInput else { return nil }
        guard let result = context
            .split(by: wordDelimiters)
            .dropLast()
            .last?
            .trimmingCharacters(in: .whitespaces)
        else { return nil }
        return result.isEmpty ? nil : result
    }
    
    /// Replace the current word with a replacement text.
    func replaceCurrentWord(with replacement: String) {
        guard let word = currentWord else { return }
        let offset = currentWordPostCursorPart?.count ?? 0
        adjustTextPosition(byCharacterOffset: offset)
        deleteBackward(times: word.count)
        insertText(replacement)
    }
}

extension UITextDocumentProxy {
    
    var wordDelimiters: [String] {
        String.wordDelimiters
    }
}

private extension UITextDocumentProxy {
    
    /// Whether to include a character in the current word.
    func shouldIncludeCharacterInCurrentWord(
        _ character: Character?
    ) -> Bool {
        guard let character = character else { return false }
        return !wordDelimiters.contains("\(character)")
    }
}
#endif
