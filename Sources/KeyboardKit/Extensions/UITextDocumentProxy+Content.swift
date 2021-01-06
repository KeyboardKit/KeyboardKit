//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 `NOTE` These concepts of words and sentences only works for
 western keyboards. We should find another approach for e.g.
 chinese and other symbol-based keyboards.
 */
public extension UITextDocumentProxy {
    
    /**
     Whether or not the text document proxy cursor is at the
     beginning of a new sentence.
     */
    var isCursorAtNewSentence: Bool {
        guard let pre = documentContextBeforeInput?.replacingOccurrences(of: " ", with: "") else { return true }
        let lastCharacter = String(pre.suffix(1))
        return pre.isEmpty || sentenceDelimiters.contains(lastCharacter)
    }
    
    /**
     Whether or not the text document proxy cursor is at the
     beginning of a new word.
     */
    var isCursorAtNewWord: Bool {
        guard let pre = documentContextBeforeInput else { return true }
        let lastCharacter = String(pre.suffix(1))
        return pre.isEmpty || wordDelimiters.contains(lastCharacter)
    }
    
    /**
     A list of characters that can be the end of a sentence.
     */
    var sentenceDelimiters: [String] {
        ["!", ".", "?"]
    }
    
    /**
     A list of characters that can separate words.
     */
    var wordDelimiters: [String] {
        var delimiters = sentenceDelimiters
        delimiters.append(contentsOf: [",", ";", ":", " "])
        return delimiters
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
