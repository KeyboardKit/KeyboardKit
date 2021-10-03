//
//  KeyboardType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains all keyboard types that can currently be
 bound to the `KeyboardAction` switch keyboard action.
 
 If you need a keyboard type that is not represented here or
 that is app-specific, you can use `.custom`.
 */
public enum KeyboardType: Codable, Equatable {
    
    /**
     `.alphabetic` represents keyboards that have alphabetic
     input keys for the current locale.
     
     This can be implemented with a `SystemKeyboard` but you
     can create custom alphabetic keyboards as well.
     */
    case alphabetic(KeyboardCasing)
    
    /**
     `.numeric` represents keyboards that have numeric input
     keys for the current locale.
     
     This can be implemented with a `SystemKeyboard` but you
     can create custom numeric keyboards as well.
     */
    case numeric
    
    /**
     `.symbolic` represents keyboards that have symbol input
     keys for the current locale.
     
     This can be implemented with a `SystemKeyboard` but you
     can create custom symbolic keyboards as well.
     */
    case symbolic
    
    /**
     `.email` represents keyboards that have e-mail specific
     input keys for the current locale.
     
     KeyboardKit currently has no built-in views that can be
     used to implement this kind of keyboard. If you want to
     use it, you must create your own keyboard view.
     */
    case email
    
    /**
     `.emoji` represents keyboards that either present emoji
     characters or emoji categories.
     
     This can be implemented with the `EmojiKeyboard` or the
     `EmojiCategoryKeyboard` but you can create custom emoji
     keyboards as well.
     */
    case emojis
    
    /**
     `.image` represents keyboards that present custom image
     buttons with custom handing.
     
     KeyboardKit currently has no built-in views that can be
     used to implement this kind of keyboard. If you want to
     use it, you must create your own keyboard view.
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
     Whether or not the keyboard type is alphabetic.
     */
    var isAlphabetic: Bool {
        switch self {
        case .alphabetic: return true
        default: return false
        }
    }
    
    /**
     Whether or not the keyboard type is alphabetic and with
     a certain shift state.
     */
    func isAlphabetic(with casingType: KeyboardCasing) -> Bool {
        switch self {
        case .alphabetic(let casing): return casing == casingType
        default: return false
        }
    }
}
