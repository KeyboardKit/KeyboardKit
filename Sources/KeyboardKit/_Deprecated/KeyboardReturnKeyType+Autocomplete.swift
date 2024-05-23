//
//  KeyboardReturnKeyType+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-08-10.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

public extension Keyboard.ReturnKeyType {

    @available(*, deprecated, message: "Use Keyboard.KeyboardType.prefersAutocomplete instead")
    var prefersAutocomplete: Bool {
        switch self {
        case .return: true
        case .continue: false
        case .done: false
        case .emergencyCall: false
        case .go: false
        case .join: false
        case .newLine: true
        case .next: false
        case .ok: true
        case .route: false
        case .search: false
        case .send: true
        case .custom: true
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UIReturnKeyType {

    @available(*, deprecated, message: "Use Keyboard.KeyboardType.prefersAutocomplete instead")
    var prefersAutocomplete: Bool {
        keyboardReturnKeyType.prefersAutocomplete
    }
}
#endif
