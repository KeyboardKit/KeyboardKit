//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /// The currently preferred keyboard type.
    ///
    /// This value is based on the current keyboard type and
    /// the ``textDocumentProxy`` autocapitalization.
    var preferredKeyboardType: Keyboard.KeyboardType {
        if keyboardType.isAlphabetic(.capsLocked) { return keyboardType }
        if let type = preferredAutocapitalizedKeyboardType { return type }
        if let type = preferredKeyboardTypeAfterAlphaTyping { return type }
        if let type = preferredKeyboardTypeAfterNumericOrSymbolicSpaceOrReturn { return type }
        return keyboardType
    }
}

private extension KeyboardContext {
    
    var preferredAutocapitalizedKeyboardType: Keyboard.KeyboardType? {
        preferredAutocapitalizedKeyboardType(requiresAlphabetic: true)
    }
    
    func preferredAutocapitalizedKeyboardType(
        requiresAlphabetic: Bool
    ) -> Keyboard.KeyboardType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        guard isAutoCapitalizationEnabled else { return nil }
        guard let proxyType = autocapitalizationType else { return nil }
        if requiresAlphabetic && !keyboardType.isAlphabetic { return nil }
        let uppercased = Keyboard.KeyboardType.alphabetic(.uppercased)
        let lowercased = Keyboard.KeyboardType.alphabetic(.lowercased)
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

    var preferredKeyboardTypeAfterAlphaTyping: Keyboard.KeyboardType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        guard keyboardType.isAlphabetic else { return nil }
        return .alphabetic(.lowercased)
        #else
        nil
        #endif
    }
    
    var preferredKeyboardTypeAfterNumericOrSymbolicSpaceOrReturn: Keyboard.KeyboardType? {
        #if os(iOS) || os(tvOS) || os(visionOS)
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
