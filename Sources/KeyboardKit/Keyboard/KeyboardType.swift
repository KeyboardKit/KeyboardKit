//
//  KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains all keyboard types that can currently be
 bound to the `KeyboardAction` switch keyboard action.

 If you need a keyboard type that is not represented here or
 that is app-specific, you can use `.custom`.
 */
public enum KeyboardType: Codable, Equatable, Identifiable {

    /**
     `.alphabetic` represents keyboards that have alphabetic
     input keys for the current locale.

     This type can be created with a ``SystemKeyboard``, but
     you can create custom alphabetic keyboards as well.
     */
    case alphabetic(KeyboardCase)

    /**
     `.numeric` represents keyboards that have numeric input
     keys for the current locale.

     This type can be created with a ``SystemKeyboard``, but
     you can create custom numeric keyboards as well.
     */
    case numeric

    /**
     `.symbolic` represents keyboards that have symbol input
     keys for the current locale.

     This type can be created with a ``SystemKeyboard``, but
     you can create custom symbolic keyboards as well.
     */
    case symbolic

    /**
     `.email` represents keyboards that have e-mail specific
     input keys for the current locale.

     KeyboardKit has no built-in view for this keyboard type,
     so if you want to use it, you must create your own.
     */
    case email

    /**
     `.emoji` represents keyboards that either present emoji
     characters or emoji categories.

     This type can be rendered with the ``EmojiKeyboard`` or
     the ``EmojiCategoryKeyboard`` views, but you can create
     custom emoji keyboards as well.
     */
    case emojis

    /**
     `.image` represents keyboards that present custom image
     buttons with custom handing.

     KeyboardKit has no built-in view for this keyboard type,
     so if you want to use it, you must create your own.
     */
    case images

    /**
     `.custom` can be used to indicate that keyboards should
     use an entirely custom type.
     */
    case custom(named: String)
}

public extension KeyboardType {

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
    func isAlphabetic(_ case: KeyboardCase) -> Bool {
        switch self {
        case .alphabetic(let current): return current == `case`
        default: return false
        }
    }
}
