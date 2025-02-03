//
//  KeyboardContext+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    /// The currently preferred keyboard case.
    var preferredKeyboardCase: Keyboard.KeyboardCase {
        if keyboardCase == .capsLocked { return .capsLocked }
        if let val = preferredAutocapitalizedCase { return val }
        return keyboardCase
    }
}

private extension KeyboardContext {
    
    var preferredAutocapitalizedCase: Keyboard.KeyboardCase? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        guard settings.isAutocapitalizationEnabled else { return nil }
        guard let autocapitalizationType else { return nil }
        if locale.isRightToLeft { return .lowercased }
        switch autocapitalizationType {
        case .allCharacters: return .uppercased
        case .sentences: return textDocumentProxy.isCursorAtNewSentenceWithTrailingWhitespace ? .uppercased : .lowercased
        case .words: return textDocumentProxy.isCursorAtNewWord ? .uppercased : .lowercased
        default: return .lowercased
        }
        #else
        nil
        #endif
    }
}
