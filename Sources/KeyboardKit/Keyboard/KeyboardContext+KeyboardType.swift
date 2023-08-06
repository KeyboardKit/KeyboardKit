//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /**
     The preferred keyboard type for the context is based on
     the current keyboard type and the text document proxy's
     `autocapitalization` configuration.
     */
    var preferredKeyboardType: KeyboardType {
        if keyboardType.isAlphabetic(.capsLocked) { return keyboardType }
        if let type = preferredAutocapitalizedKeyboardType { return type }
        if let type = preferredKeyboardTypeAfterAlphaTyping { return type }
        if let type = preferredKeyboardTypeAfterNumericOrSymbolicSpaceOrReturn { return type }
        return keyboardType
    }
}

private extension KeyboardContext {
    
    var preferredAutocapitalizedKeyboardType: KeyboardType? {
        preferredAutocapitalizedKeyboardType(requiresAlphabetic: true)
    }
    
    func preferredAutocapitalizedKeyboardType(
        requiresAlphabetic: Bool
    ) -> KeyboardType? {
        #if os(iOS) || os(tvOS)
        guard isAutoCapitalizationEnabled else { return nil }
        guard let proxyType = autocapitalizationType else { return nil }
        if requiresAlphabetic && !keyboardType.isAlphabetic { return nil }
        let uppercased = KeyboardType.alphabetic(.uppercased)
        let lowercased = KeyboardType.alphabetic(.lowercased)
        if locale.isRightToLeft { return lowercased }
        switch proxyType {
        case .allCharacters: return uppercased
        case .sentences: return textDocumentProxy.isCursorAtNewSentenceWithTrailingWhitespace ? uppercased : lowercased
        case .words: return textDocumentProxy.isCursorAtNewWord ? uppercased : lowercased
        default: return lowercased
        }
        #else
        nil
        #endif
    }

    var preferredKeyboardTypeAfterAlphaTyping: KeyboardType? {
        #if os(iOS) || os(tvOS)
        guard keyboardType.isAlphabetic else { return nil }
        return .alphabetic(.lowercased)
        #else
        nil
        #endif
    }
    
    var preferredKeyboardTypeAfterNumericOrSymbolicSpaceOrReturn: KeyboardType? {
        #if os(iOS) || os(tvOS)
        guard keyboardType == .numeric || keyboardType == .symbolic else { return nil }
        guard let before = textDocumentProxy.documentContextBeforeInput else { return nil }
        let preferred = preferredAutocapitalizedKeyboardType(requiresAlphabetic: false)
        if before.hasSuffix(" ") && !before.hasSuffix("  ") { return preferred }
        if before.hasSuffix("\n") && before.isLastSentenceEnded { return preferred }
        return nil
        #else
        nil
        #endif
    }
}
