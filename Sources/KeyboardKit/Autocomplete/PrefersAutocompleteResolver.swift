//
//  KeyboardType+Autocomplete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

/**
 This protocol can be implemented by any type that can check
 if autocomplete is preferred.

 This protocol is implemented by ``KeyboardType`` as well as
 the `UIKeyboardType` in `UIKit`.
 */
public protocol PrefersAutocompleteResolver {

    /**
     Whether or not this provider prefers auto complete.
     */
    var prefersAutocomplete: Bool { get }
}

extension KeyboardType: PrefersAutocompleteResolver {}

public extension KeyboardType {

    /**
     Whether or not this keyboard type prefers auto complete.
     */
    var prefersAutocomplete: Bool {
        switch self {
        case .alphabetic: return true
        case .numeric: return true
        case .symbolic: return true
        case .email: return false
        case .emojis: return false
        case .images: return false
        case .custom: return true
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit

extension UIKeyboardType: PrefersAutocompleteResolver {}

public extension UIKeyboardType {

    /**
     Whether or not this keyboard type prefers auto complete.
     */
    var prefersAutocomplete: Bool {
        switch self {
        case .default: return true
        case .alphabet: return true
        case .asciiCapableNumberPad: return false
        case .asciiCapable: return true
        case .decimalPad: return false
        case .emailAddress: return false
        case .namePhonePad: return false
        case .numberPad: return false
        case .numbersAndPunctuation: return false
        case .phonePad: return false
        case .twitter: return true
        case .URL: return false
        case .webSearch: return false
        @unknown default: return true
        }
    }
}
#endif
