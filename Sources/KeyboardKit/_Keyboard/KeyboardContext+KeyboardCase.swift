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
        case .sentences: return textDocumentProxy.shouldApplySentenceAutocapitalization ? .uppercased : .lowercased
        case .words: return textDocumentProxy.shouldApplyWordAutocapitalization ? .uppercased : .lowercased
        default: return .lowercased
        }
        #else
        nil
        #endif
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

private extension UITextDocumentProxy {

    var shouldApplySentenceAutocapitalization: Bool {
        isCursorAtNewLine || isCursorAtNewSentenceWithTrailingWhitespace
    }

    var shouldApplyWordAutocapitalization: Bool {
        isCursorAtNewLine || isCursorAtNewWord
    }
}
#endif
