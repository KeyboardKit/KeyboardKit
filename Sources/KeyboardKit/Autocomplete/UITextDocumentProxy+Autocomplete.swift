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
    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion, tryInsertSpace: Bool = true) {
        replaceCurrentWord(with: suggestion.text)
        guard tryInsertSpace else { return }
        tryInsertSpaceAfterSuggestion()
    }
    
    /**
     Remove any auto-inserted space before the current input,
     that were inserted by `insertAutocompleteSuggestion`.
     */
    func tryRemoveAutocompleteInsertedSpace() {
        guard
            let text = documentContextBeforeInput,
            text.hasSuffix(" "),
            ProxyState.hasAutoInsertedSpace
        else { return }
        deleteBackward()
        ProxyState.hasAutoInsertedSpace = false
    }
}

private extension UITextDocumentProxy {
    
    func tryInsertSpaceAfterSuggestion() {
        let space = " "
        let hasPreviousSpace = documentContextBeforeInput?.hasSuffix(space) ?? false
        let hasNextSpace = documentContextAfterInput?.hasPrefix(space) ?? false
        if hasPreviousSpace || hasNextSpace { return }
        insertText(space)
        ProxyState.hasAutoInsertedSpace = true
    }
}

/**
 This class is a private way to store state for a text proxy.
 */
private final class ProxyState {
    
    private init() {}
    
    /**
     This flag is used to keep track of if a space character
     has been inserted by `insertAutocompleteSuggestion`.
     
     Note that it is static and not thread safe. However, it
     is short-lived, since the standard action handler calls
     `tryRemoveAutocompleteInsertedSpace` for each action.
     */
    static var hasAutoInsertedSpace = false
}
