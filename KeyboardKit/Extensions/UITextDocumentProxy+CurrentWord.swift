//
//  UITextDocumentProxy+CurrentWord.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This extension helps you resolve the word that is currently
 being typed or where the cursor is currently placed.
 
 The two component properties represent the part of the word
 that is before and after the cursor.
 
 TODO: Unit test
 
 */

import UIKit

public extension UITextDocumentProxy {
    
    var currentWord: String? {
        let pre = currentWordPreCursorComponent
        let post = currentWordPostCursorComponent
        if pre == nil && post == nil { return nil }
        return (pre ?? "") + (post ?? "")
    }
    
    var currentWordPreCursorComponent: String? {
        guard let string = documentContextBeforeInput else { return nil }
        guard let last = string.last else { return nil }
        if wordSeparators.contains("\(last)") { return nil }
        var result = ""
        string.enumerateSubstrings(in: string.startIndex..., options: .byWords) { word, _, _, _ in
            result = word ?? result
        }
        return result
    }
    
    var currentWordPostCursorComponent: String? {
        guard let string = documentContextAfterInput else { return nil }
        guard let first = string.first else { return nil }
        if wordSeparators.contains("\(first)") { return nil }
        var result: String?
        string.enumerateSubstrings(in: string.startIndex..., options: .byWords) { word, _, _, _ in
            result = result ?? word ?? ""
        }
        return result
    }
}

private extension UITextDocumentProxy {
    
    var wordSeparators: [String] {
        return ["!", ".", ",", " "]
    }
}
