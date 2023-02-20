//
//  UITextDocumentProxy+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {
    
    /**
     Whether or not the proxy has a space before the current
     input, that has been inserted by autocomplete.
     */
    var hasAutocompleteInsertedSpace: Bool {
        ProxyState.state == .autoInserted && documentContextBeforeInput?.hasSuffix(" ") == true
    }
    
    /**
     Whether or not the proxy has removed a space before the
     current input, that has been inserted by autocomplete.
     */
    var hasAutocompleteRemovedSpace: Bool {
        ProxyState.state == .autoRemoved
    }
    
    /**
     Replace the current word in the proxy with a suggestion,
     then try to insert a space, if applicable.
     
     If a space is automatically inserted, the proxy will be
     set to an `autoInserted` state.
     */
    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion, tryInsertSpace: Bool = true) {
        replaceCurrentWord(with: suggestion.text)
        guard tryInsertSpace else { return }
        tryInsertSpaceAfterAutocomplete()
    }
    
    /**
     Try inserting a space into the proxy after inserting an
     autocompete suggestion.
     
     Calling this function instead of just inserting a space
     puts the proxy in the correct autocomplete state.
     */
    func tryInsertSpaceAfterAutocomplete() {
        let space = " "
        let hasPreviousSpace = documentContextBeforeInput?.hasSuffix(space) ?? false
        let hasNextSpace = documentContextAfterInput?.hasPrefix(space) ?? false
        if hasPreviousSpace || hasNextSpace { return }
        insertText(space)
        setState(.autoInserted)
    }
    
    /**
     Try re-inserting any space that were previously removed
     by `tryRemoveAutocompleteInsertedSpace`.
     */
    func tryReinsertAutocompleteRemovedSpace() {
        if hasAutocompleteRemovedSpace { insertText(" ") }
        resetState()
    }
    
    /**
     Try removing any space before the current text input if
     is was inserted by `insertAutocompleteSuggestion`.
     
     If a space is automatically removed, this proxy will be
     set to an `autoRemoved` state.
     */
    func tryRemoveAutocompleteInsertedSpace() {
        guard hasAutocompleteInsertedSpace else { return resetState() }
        deleteBackward()
        setState(.autoRemoved)
    }
}

private extension UITextDocumentProxy {
    
    func resetState() {
        setState(.none)
    }
    
    func setState(_ state: AutocompleteSpaceState) {
        ProxyState.state = state
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
     */
    static var state = AutocompleteSpaceState.none
}
#endif
