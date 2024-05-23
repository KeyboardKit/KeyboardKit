//
//  KeyboardType+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

public extension Keyboard.KeyboardType {

    /// Whether or not this type prefers autocomplete.
    ///
    /// Use both ``Keyboard/KeyboardType`` & `UIKeyboardType`
    /// to compute this, since many native keyboard types do
    /// not map to a corresponding ``Keyboard/KeyboardType``.
    /// This means that a `.URL` keyboard type (which should
    /// not use autocomplete) is rendered as an `.alphabetic`
    /// keyboard (which by default does). Both should prefer
    /// autocomplete for it to be used.
    var prefersAutocomplete: Bool {
        switch self {
        case .alphabetic: true
        case .numeric: true
        case .symbolic: true
        case .email: false
        case .emojis: false
        case .images: false
        case .numberPad: true
        case .custom: true
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UIKeyboardType {

    /// Whether or not this type prefers autocomplete.
    ///
    /// Use both ``Keyboard/KeyboardType`` & `UIKeyboardType`
    /// to compute this, since many native keyboard types do
    /// not map to a corresponding ``Keyboard/KeyboardType``.
    /// This means that a `.URL` keyboard type (which should
    /// not use autocomplete) is rendered as an `.alphabetic`
    /// keyboard (which by default does). Both should prefer
    /// autocomplete for it to be used.
    var prefersAutocomplete: Bool {
        switch self {
        case .default: true
        case .alphabet: true
        case .asciiCapableNumberPad: false
        case .asciiCapable: true
        case .decimalPad: false
        case .emailAddress: false
        case .namePhonePad: false
        case .numberPad: false
        case .numbersAndPunctuation: false
        case .phonePad: false
        case .twitter: true
        case .URL: false
        case .webSearch: false
        @unknown default: true
        }
    }
}
#endif
