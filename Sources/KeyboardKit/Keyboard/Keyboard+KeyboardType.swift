//
//  Keyboard+KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension Keyboard {
    
    /**
     This enum defines various keyboard types, of which some
     are implemented by the library.
     
     The ``SystemKeyboard`` can be used to render alphabetic,
     numeric, symbolic and emoji keyboards. You just have to
     set ``KeyboardContext/keyboardType`` to a keyboard type
     that you want to use, and it will render it.
     
     If you want to use a keyboard type that isn't supported
     by the system keyboard (yet), you can implement it with
     a custom ``KeyboardLayout`` and just inject it into the
     system keyboard.
     */
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
        
        /// A custom keyboard type, if you need to use one.
        case custom(named: String)
    }
}

public extension Keyboard.KeyboardType {

    /**
     The type's unique identifier.
     */
    var id: String {
        switch self {
        case .alphabetic(let casing): return casing.id
        case .numeric: return "numeric"
        case .symbolic: return "symbolic"
        case .email: return "email"
        case .emojis: return "emojis"
        case .images: return "images"
        case .custom(let name): return name
        }
    }

    /**
     Whether or not the keyboard type is alphabetic.
     */
    var isAlphabetic: Bool {
        switch self {
        case .alphabetic: return true
        default: return false
        }
    }

    /**
     Whether or not this keyboard type is alphabetic and has
     an uppercased or capslocked shift state.
     */
    var isAlphabeticUppercased: Bool {
        switch self {
        case .alphabetic(let current): return current.isUppercased
        default: return false
        }
    }

    /**
     Whether or not this keyboard type is alphabetic and has
     a certain shift state.
     */
    func isAlphabetic(_ case: Keyboard.Case) -> Bool {
        switch self {
        case .alphabetic(let current): return current == `case`
        default: return false
        }
    }
}

public extension Keyboard.KeyboardType {
    
    /**
     The keyboard type's standard button image.
     */
    var standardButtonImage: Image? {
        switch self {
        case .email: return .keyboardEmail
        case .emojis: return .keyboardEmoji
        case .images: return .keyboardImages
        default: return nil
        }
    }
    
    /**
     The keyboard type's standard button text.
     */
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .alphabetic: return KKL10n.keyboardTypeAlphabetic.text(for: context)
        case .numeric: return KKL10n.keyboardTypeNumeric.text(for: context)
        case .symbolic: return KKL10n.keyboardTypeSymbolic.text(for: context)
        default: return nil
        }
    }
}
