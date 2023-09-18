//
//  KeyboardReturnKeyType+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

public extension Keyboard.ReturnKeyType {

    /// Whether or not this type prefers autocomplete.
    var prefersAutocomplete: Bool {
        switch self {
        case .return: return true
        case .continue: return false
        case .done: return false
        case .emergencyCall: return false
        case .go: return false
        case .join: return false
        case .newLine: return true
        case .next: return false
        case .ok: return true
        case .route: return false
        case .search: return false
        case .send: return true
        case .custom: return true
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit

public extension UIReturnKeyType {

    /// Whether or not this type prefers autocomplete.
    var prefersAutocomplete: Bool {
        keyboardReturnKeyType.prefersAutocomplete
    }
}
#endif
