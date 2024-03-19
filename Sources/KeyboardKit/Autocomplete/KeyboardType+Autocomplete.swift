//
//  KeyboardType+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

public extension Keyboard.KeyboardType {

    /// Whether or not this type prefers autocomplete.
    var prefersAutocomplete: Bool {
        switch self {
        case .alphabetic: true
        case .numeric: true
        case .symbolic: true
        case .email: false
        case .emojis: false
        case .images: false
        case .custom: true
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit

public extension UIKeyboardType {

    /// Whether or not this type prefers autocomplete.
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
