//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

public extension KeyboardContext {
    
    /**
     The preferred keyboard type for the context is based on
     the current keyboard type and the text document proxy's
     autocapitalization type.
     */
    var preferredKeyboardType: KeyboardType {
        if keyboardType.isAlphabetic(with: .capsLocked) { return keyboardType }
        if let type = preferredAutocapitalizedKeyboardType { return type }
        if let type = preferredKeyboardTypeAfterNonAlphaSpace { return type }
        return keyboardType
    }
}

private extension KeyboardContext {
    
    var preferredAutocapitalizedKeyboardType: KeyboardType? {
        guard let autoType = textDocumentProxy.autocapitalizationType else { return nil }
        guard keyboardType.isAlphabetic else { return nil }
        let uppercased = KeyboardType.alphabetic(.uppercased)
        let lowercased = KeyboardType.alphabetic(.lowercased)
        switch autoType {
        case .allCharacters: return uppercased
        case .sentences: return textDocumentProxy.isCursorAtNewSentence ? uppercased : lowercased
        case .words: return textDocumentProxy.isCursorAtNewWord ? uppercased : lowercased
        default: return lowercased
        }
    }
    
    var preferredKeyboardTypeAfterNonAlphaSpace: KeyboardType? {
        guard
            keyboardType == .numeric || keyboardType == .symbolic,
            let before = textDocumentProxy.documentContextBeforeInput,
            before.hasSuffix(" ") && !before.hasSuffix("  ")
        else { return nil }
        keyboardType = .alphabetic(.lowercased)
        return preferredAutocapitalizedKeyboardType
    }
}

