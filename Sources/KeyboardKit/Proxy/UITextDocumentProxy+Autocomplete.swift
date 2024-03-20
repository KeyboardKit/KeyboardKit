//
//  UITextDocumentProxy+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {
    
    /// Whether the proxy has an autocomplete inserted space.
    var hasAutocompleteInsertedSpace: Bool {
        ProxyState.spaceState == .autoInserted && documentContextBeforeInput?.hasSuffix(" ") == true
    }
    
    /// Whether the proxy has an autocomplete removed space.
    var hasAutocompleteRemovedSpace: Bool {
        ProxyState.spaceState == .autoRemoved
    }
    
    /// Replace the current word in the texts document proxy
    /// with a suggestion, then try to insert a space.
    ///
    /// If a space is automatically inserted, the proxy will
    /// be set to an `autoInserted` state.
    func insertAutocompleteSuggestion(
        _ suggestion: Autocomplete.Suggestion,
        tryInsertSpace: Bool = true
    ) {
        replaceCurrentWord(with: suggestion.text)
        guard tryInsertSpace else { return }
        tryInsertSpaceAfterAutocomplete()
    }
    
    /// Try to insert a space into the proxy after inserting
    /// an autocompete suggestion.
    ///
    /// Call this function instead of just inserting a space
    /// to apply the correct autocomplete state to the proxy.
    func tryInsertSpaceAfterAutocomplete() {
        let space = " "
        let hasPreviousSpace = documentContextBeforeInput?.hasSuffix(space) ?? false
        let hasNextSpace = documentContextAfterInput?.hasPrefix(space) ?? false
        if hasPreviousSpace || hasNextSpace { return }
        insertText(space)
        setState(.autoInserted)
    }
    
    /// Try to re-insert a space that was previously removed
    /// by `tryRemoveAutocompleteInsertedSpace`.
    func tryReinsertAutocompleteRemovedSpace() {
        if hasAutocompleteRemovedSpace { insertText(" ") }
        resetState()
    }
    
    /// Try to remove any space before the text input, if it
    /// was inserted by `insertAutocompleteSuggestion`.
    ///
    /// If a space is automatically removed, this proxy will
    /// be set to an `autoRemoved` state.
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
    
    func setState(_ state: ProxyAutocompleteSpaceState) {
        ProxyState.spaceState = state
    }
}

/// This class is a private text document proxy storage type.
private final class ProxyState {
    
    private init() {}
    
    /// This state is used to keep track if a space has been
    /// inserted by `insertAutocompleteSuggestion`.
    static var spaceState = ProxyAutocompleteSpaceState.none
}

enum ProxyAutocompleteSpaceState {
    
    /// The proxy is not in any certain state.
    case none
    
    /// The proxy has an auto-inserted space.
    case autoInserted
    
    /// The proxy has an auto-removed space.
    case autoRemoved
}
#endif
