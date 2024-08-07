//
//  Keyboard+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension Keyboard {
    
    /// This enum defines various keyboard types, of which a
    /// few are already implemented by the library.
    ///
    /// The ``SystemKeyboard`` will automatically render the
    /// ``alphabetic(_:)``, ``numeric`` & ``symbolic`` types,
    /// as well as ``emojis`` if KeyboardKit Pro is unlocked.
    /// The rest must be handled manually.
    ///
    /// Just set the ``KeyboardContext/keyboardType`` to any
    /// type you want to use, then observe the value.
    enum KeyboardType: Codable, Equatable, Identifiable {
        
        /// A keyboard with alphabetic input keys.
        case alphabetic(Keyboard.Case)
        
        /// A keyboard with numeric input keys.
        case numeric
        
        /// A keyboard with symbolic input keys.
        case symbolic
        
        /// An e-mail keyboard, not currently implemented.
        case email
        
        /// An emoji keyboard, with emojis and categories.
        case emojis
        
        /// An image keyboard, not currently implemented.
        case images
        
        /// A number pad keyboard.
        case numberPad
        
        /// A custom keyboard type, if you need to use one.
        case custom(named: String)
    }
}

public extension Keyboard.KeyboardType {

    /// The type's unique identifier.
    var id: String {
        switch self {
        case .alphabetic(let casing): casing.id
        case .numeric: "numeric"
        case .symbolic: "symbolic"
        case .email: "email"
        case .emojis: "emojis"
        case .images: "images"
        case .numberPad: "numberPad"
        case .custom(let name): name
        }
    }

    /// Whether or not the type is alphabetic.
    var isAlphabetic: Bool {
        switch self {
        case .alphabetic: true
        default: false
        }
    }
    
    /// Whether or not the type is caps locked.
    var isAlphabeticCapsLocked: Bool {
        switch self {
        case .alphabetic(let current): current.isCapsLocked
        default: false
        }
    }

    /// Whether or not the type is uppercased alphabetic.
    var isAlphabeticUppercased: Bool {
        switch self {
        case .alphabetic(let current): current.isUppercased
        default: false
        }
    }

    /// Whether or not the type is an alphabetic state type.
    func isAlphabetic(_ case: Keyboard.Case) -> Bool {
        switch self {
        case .alphabetic(let current): current == `case`
        default: false
        }
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
        case .default: .alphabetic(.auto)
        case .asciiCapable: nil
        case .numbersAndPunctuation: .numeric
        case .URL: .alphabetic(.auto)
        case .numberPad: .numberPad
        case .phonePad: nil
        case .namePhonePad: nil
        case .emailAddress: .alphabetic(.auto)
        case .decimalPad: nil
        case .twitter: .alphabetic(.auto)
        case .webSearch: .alphabetic(.auto)
        case .asciiCapableNumberPad: .numberPad
        case .alphabet: .alphabetic(.auto)
        @unknown default: .alphabetic(.auto)
        }
    }
}
#endif
