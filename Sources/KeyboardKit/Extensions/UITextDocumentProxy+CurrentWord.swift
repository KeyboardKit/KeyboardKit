//
//  UITextDocumentProxy+CurrentWord.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    /**
     The word that is currently being touched by the cursor.
     
     IMPORTANT: This property suffers from an iOS bug, where
     the pre and post context don't contain the current word
     in its correct form until the cursor's position changes.
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
     A list of characters that represent the end of a word.
     */
    var wordDelimiters: [String] {
        return ["!", ".", ",", " "]
    }
    
    /**
     Check if a certain character should be included in the
     current word.
     */
    func shouldIncludeCharacterInCurrentWord(_ character: Character?) -> Bool {
        guard let character = character else { return false }
        return !wordDelimiters.contains("\(character)")
    }
}
