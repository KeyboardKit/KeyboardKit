//
//  KeyboardAutocapitalizationType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-26.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines all supported auto-capitalization types.
 */
public enum KeyboardAutocapitalizationType: String, CaseIterable {

    // All characters should be auto-capitalized.
    case allCharacters

    // All new sentences should be auto-capitalized.
    case sentences

    // All new words should be auto-capitalized.
    case words

    // Auto-capitalization should not be applied.
    case none
}

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextAutocapitalizationType {

    /**
     Get the KeyboardKit-specific auto-capitalization type.
     */
    var keyboardType: KeyboardAutocapitalizationType {
        switch self {
        case .none: return .none
        case .words: return .words
        case .sentences: return .sentences
        case .allCharacters: return .allCharacters
        @unknown default: return .none
        }
    }
}
#endif
