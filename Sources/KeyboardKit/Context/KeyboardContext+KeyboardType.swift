//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension KeyboardContext {
    
    /**
     The preferred keyboard type for the context is based on
     the current keyboard type and the text document proxy's
     autocapitalizationType.
     */
    var preferredKeyboardType: KeyboardType {
        let proxy = textDocumentProxy
        guard let autoType = proxy.autocapitalizationType else { return keyboardType }
        guard keyboardType.isAlphabetic else { return keyboardType }
        let uppercased = KeyboardType.alphabetic(.uppercased)
        switch autoType {
        case .allCharacters: return uppercased
        case .sentences: return proxy.isCursorAtNewSentence ? uppercased : keyboardType
        case .words: return proxy.isCursorAtNewWord ? uppercased : keyboardType
        default: return .alphabetic(.lowercased)
        }
    }
}
