//
//  Keyboard+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension Keyboard {
    
    /// This enum defines various keyboard types, of which a
    /// few are implemented by the library.
    ///
    /// ``KeyboardView`` automatically renders some of these
    /// keyboard types. All other types require custom views.
    /// You can also use a ``custom(named:)`` type to create
    /// a completely custom keyboard type from scratch.
    ///
    /// Just set the ``KeyboardContext/keyboardType`` to any
    /// type you want to use, then observe the value to make
    /// any customizations needed for your app.
    enum KeyboardType: CaseIterable, Identifiable, KeyboardModel {

        /// A keyboard with alphabetic input keys.
        case alphabetic

        /// An e-mail keyboard.
        case email

        /// An emoji keyboard with emojis and categories.
        case emojis

        /// An emoji search bar with the alphabetic keyboard.
        case emojiSearch

        /// An image keyboard, not currently implemented.
        case images
        
        /// A number pad keyboard.
        case numberPad

        /// A keyboard with numeric input keys.
        case numeric

        /// A keyboard with symbolic input keys.
        case symbolic

        /// A URL keyboard
        case url
        
        /// A custom keyboard type, if you need to use one.
        case custom(named: String)
    }
}

public extension Keyboard.KeyboardType {

    /// Get a list of all standard available keyboard types.
    static var allCases: [Self] {
        [
            .alphabetic,
            .email,
            .emojis,
            .emojiSearch,
            .images,
            .numberPad,
            .numeric,
            .symbolic,
            .url
        ]
    }
}

public extension Keyboard.KeyboardType {

    /// The type's unique identifier.
    var id: String {
        switch self {
        case .alphabetic: "alphabetic"
        case .email: "email"
        case .emojis: "emojis"
        case .emojiSearch: "emojiSearch"
        case .images: "images"
        case .numberPad: "numberPad"
        case .numeric: "numeric"
        case .symbolic: "symbolic"
        case .url: "url"
        case .custom(let name): name
        }
    }

    /// Whether the type is numeric or symbolic.
    var isNumericOrSymbolic: Bool {
        self == .numeric || self == .symbolic
    }
}

public extension Keyboard.KeyboardType {
    
    /// The keyboard type's standard button image.
    var standardButtonImage: Image? {
        switch self {
        case .email: .keyboardEmail
        case .emojis: .keyboardEmoji
        case .images: .keyboardImages
        default: nil
        }
    }
    
    /// The keyboard type's standard button text.
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .alphabetic: KKL10n.switcherAlphabetic.text(for: context)
        case .numeric: KKL10n.switcherNumeric.text(for: context)
        case .symbolic: KKL10n.switcherSymbolic.text(for: context)
        default: nil
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
public extension UIKeyboardType {
 
    /// The ``Keyboard/KeyboardType`` this type represents.
    var keyboardType: Keyboard.KeyboardType? {
        switch self {
        case .default: .alphabetic
        case .alphabet: .alphabetic
        case .asciiCapable: nil
        case .asciiCapableNumberPad: .numberPad
        case .decimalPad: nil
        case .emailAddress: .email
        case .namePhonePad: nil
        case .numberPad: .numberPad
        case .numbersAndPunctuation: .numeric
        case .phonePad: nil
        case .twitter: .alphabetic
        case .URL: .url
        case .webSearch: .alphabetic
        @unknown default: .alphabetic
        }
    }
}
#endif
