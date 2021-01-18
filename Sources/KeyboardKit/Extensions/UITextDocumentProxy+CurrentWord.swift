//
//  UITextDocumentProxy+CurrentWord.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

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
        guard var string = documentContextBeforeInput else { return nil }
        var result = ""
        while let char = string.popLast() {
            guard shouldIncludeCharacterInCurrentWord(char) else { return result }
            result.insert(char, at: result.startIndex)
        }
        return result
    }
    
    /**
     The part of the current word that is after the cursor.
     */
    var currentWordPostCursorPart: String? {
        guard let string = documentContextAfterInput else { return nil }
        var reversed = String(string.reversed())
        var result = ""
        while let char = reversed.popLast() {
            guard shouldIncludeCharacterInCurrentWord(char) else { return result }
            result.append(char)
        }
        return result
    }
    
    /**
     Whether or not the text document proxy cursor is at the
     end of the current word.
     */
    var isCursorAtTheEndOfTheCurrentWord: Bool {
        if currentWord == nil { return false }
        let postCount = currentWordPostCursorPart?.trimmingCharacters(in: .whitespaces).count ?? 0
        if postCount > 0 { return false }
        guard let pre = currentWordPreCursorPart else { return false }
        let lastCharacter = String(pre.suffix(1))
        return !wordDelimiters.contains(lastCharacter)
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


// MARK: - Internal Properties

extension UITextDocumentProxy {
    
    /**
     Check if a certain character should be included in the
     current word.
     */
    func shouldIncludeCharacterInCurrentWord(_ character: Character?) -> Bool {
        guard let character = character else { return false }
        return !wordDelimiters.contains("\(character)")
    }
}
