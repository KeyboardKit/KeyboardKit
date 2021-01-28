//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {
    
    /**
     The preferred keyboard type for the context is based on
     the current keyboard type and the text document proxy's
     autocapitalization type.
     */
    var preferredKeyboardType: KeyboardType {
        let proxy = textDocumentProxy
        guard let autoType = proxy.autocapitalizationType else { return keyboardType }
        if keyboardType.isAlphabetic(with: .capsLocked) { return keyboardType }
        guard keyboardType.isAlphabetic else { return keyboardType }
        let uppercased = KeyboardType.alphabetic(.uppercased)
        let lowercased = KeyboardType.alphabetic(.lowercased)
        switch autoType {
        case .allCharacters: return uppercased
        case .sentences: return proxy.isCursorAtNewSentence ? uppercased : lowercased
        case .words: return proxy.isCursorAtNewWord ? uppercased : lowercased
        default: return lowercased
        }
    }
}
