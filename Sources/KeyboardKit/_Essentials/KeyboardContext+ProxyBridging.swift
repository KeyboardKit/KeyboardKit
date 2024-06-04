//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This TEMPORARY extension is used internally, to abstract
/// the proxy and make the context multi-platform supporting.
///
/// Since some of the abstractions return invalid result for
/// e.g. macOS and watchOS, make sure to replace them later.
extension KeyboardContext {
    
    func insertAutocompleteSuggestion(
        _ suggestion: Autocomplete.Suggestion,
        tryInsertSpace: Bool = true
    ) {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.insertAutocompleteSuggestion(
            suggestion,
            tryInsertSpace: tryInsertSpace
        )
        #endif
    }
    
    var isCursorAtNewWord: Bool {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.isCursorAtNewWord
        #else
        return false
        #endif
    }
    
    func preferredQuotationReplacement(
        whenInserting text: String,
        for locale: Locale
    ) -> String? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.documentContextBeforeInput?.preferredQuotationReplacement(whenAppending: text, for: locale)
        #else
        return nil
        #endif
    }
    
    func spaceDragOffset(for rawOffset: Int) -> Int? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.spaceDragOffset(for: rawOffset)
        #else
        return nil
        #endif
    }
    
    func tryReinsertAutocompleteRemovedSpace() {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.tryReinsertAutocompleteRemovedSpace()
        #endif
    }
    
    func tryRemoveAutocompleteInsertedSpace() {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.tryRemoveAutocompleteInsertedSpace()
        #endif
    }
}
