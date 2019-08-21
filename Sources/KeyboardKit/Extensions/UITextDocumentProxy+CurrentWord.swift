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
     
     TODO: This property suffers from an iOS bug, where the
     pre and post context will not contain the current word
     after the user has accepted or rejected an autocorrect
     suggestion from the system.
     
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
     
     This is a list of text characters that can be seen as a
     way to end a sentence. It can most probably be improved.
     
     */
    var wordDelimiters: [String] {
        return ["!", ".", ",", " "]
    }
    
    /**
     
     Whether or not a character should be included in the
     current word, given the word delimiter list.
 
     */
    func shouldIncludeCharacterInCurrentWord(_ character: Character?) -> Bool {
        guard let character = character else { return false }
        return !wordDelimiters.contains("\(character)")
    }
}
