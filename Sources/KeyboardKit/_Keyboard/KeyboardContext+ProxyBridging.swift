//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 These TEMPORARY extensions are used internally, to abstract
 the proxy and make the context compile for multi-platform.
 
 Since some of these abstractions will return invalid result
 on e.g. macOS and watchOS, make sure to replace them later.
 */
extension KeyboardContext {
    
    func endSentence() {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.endSentence()
        #endif
    }
    
    func insertAutocompleteSuggestion(
        _ suggestion: Autocomplete.Suggestion,
        tryInsertSpace: Bool = true
    ) {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.insertAutocompleteSuggestion(
            suggestion,
            tryInsertSpace: tryInsertSpace
        )
        #else
        return
        #endif
    }
    
    var isCursorAtNewWord: Bool {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.isCursorAtNewWord
        #else
        return false
        #endif
    }
    
    func preferredQuotationReplacement(
        whenInserting text: String,
        for locale: Locale
    ) -> String? {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.documentContextBeforeInput?.preferredQuotationReplacement(whenAppending: text, for: locale)
        #else
        return nil
        #endif
    }
    
    func spaceDragOffset(for rawOffset: Int) -> Int? {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.spaceDragOffset(for: rawOffset)
        #else
        return nil
        #endif
    }
    
    func tryReinsertAutocompleteRemovedSpace() {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.tryReinsertAutocompleteRemovedSpace()
        #endif
    }
    
    func tryRemoveAutocompleteInsertedSpace() {
        #if os(iOS) || os(tvOS)
        textDocumentProxy.tryRemoveAutocompleteInsertedSpace()
        #endif
    }
}
