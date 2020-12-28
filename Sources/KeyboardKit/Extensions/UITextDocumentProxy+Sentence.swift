//
//  UITextDocumentProxy+EndSentence.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    /**
     End the current sentence by removing all trailing space
     characters, then injecting a dot and a space.
     
     `NOTE` This only works for western keyboards. We should
     find another approach for e.g. chinese keyboards.
     */
    func endSentence() {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText(". ")
    }
    
    /**
     A list of characters that represent the end of a word.
     
     `NOTE` This only works for western keyboards. We should
     find another approach for e.g. chinese keyboards.
     */
    var wordDelimiters: [String] {
        ["!", ".", ",", "?", ";", ":", " "]
    }
}
