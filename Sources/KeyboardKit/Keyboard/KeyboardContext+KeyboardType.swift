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
     autocapitalization type.
     */
    var preferredKeyboardType: KeyboardType {
        if keyboardType.isAlphabetic(.capsLocked) { return keyboardType }
        if let type = preferredAutocapitalizedKeyboardType { return type }
        if let type = preferredKeyboardTypeAfterAlphaTyping { return type }
        if let type = preferredKeyboardTypeAfterNonAlphaSpace { return type }
        return keyboardType
    }
}

private extension KeyboardContext {
    
    var preferredAutocapitalizedKeyboardType: KeyboardType? {
        #if os(iOS) || os(tvOS)
        guard isAutoCapitalizationEnabled else { return nil }
        guard let proxyType = autocapitalizationType else { return nil }
        guard keyboardType.isAlphabetic else { return nil }
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
    
    var preferredKeyboardTypeAfterNonAlphaSpace: KeyboardType? {
        #if os(iOS) || os(tvOS)
        guard keyboardType == .numeric || keyboardType == .symbolic else { return nil }
        guard let before = textDocumentProxy.documentContextBeforeInput else { return nil }
        guard before.hasSuffix(" ") && !before.hasSuffix("  ") else { return nil }
        keyboardType = .alphabetic(.lowercased)
        return preferredAutocapitalizedKeyboardType
        #else
        nil
        #endif
    }
}
