//
//  UITextDocumentProxy+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    /**
     Replace the current word with the suggestion's text and
     the try to insert a space, if needed.
     */
    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion) {
        replaceCurrentWord(with: suggestion.text)
        tryInsertSpaceAfterSuggestion()
    }
}

public extension UITextDocumentProxy {
    
    func tryInsertSpaceAfterSuggestion() {
        let space = " "
        let hasPreviousSpace = documentContextBeforeInput?.hasSuffix(space) ?? false
        let hasNextSpace = documentContextAfterInput?.hasPrefix(space) ?? false
        if hasPreviousSpace || hasNextSpace { return }
        insertText(space)
    }
}

